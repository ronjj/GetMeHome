import requests
import json
from bs4 import BeautifulSoup
import urllib

"""
Bus Routes:

This module sends a request to MegaBus, Flixbus, and OurBus 
APIs and returns the trips for a given date, departure location,
and arrival location from each service.

Inputs:
- Dates:
    - must be input in format: "01-01-2000"
    - first 2 characters are month, second two are day, and last 4 are year
- Locations 
    - ithaca for "Ithaca"
    - new_york for "New York"

Output:
Returns a list of Trip objects in ascending order of price
"""


class Trip:
    def __init__(self, date, price, arr_time, arr_location, dep_time, dep_location, bus_serivce, non_stop="N/A"):
        self.date = date
        self.price = price
        self.arrival = [arr_time, arr_location]
        self.departure = [dep_time, dep_location]
        self.bus_service = bus_serivce
        self.non_stop = non_stop
    
    def __str__(self) -> str:
        return f"date: {self.date}, price: {self.price}, dep: {self.departure}, arr:{self.arrival}, bus: {self.bus_service}, non-stop:{self.non_stop}"

trips = {"trips": []}

# OurBus
# Date Format: 12/15/2023
def get_our_bus(date,dep_loc,arr_loc):
    month = date[:2]
    day = date[3:5]
    year = date[6:]
    proper_date = f"{month}/{day}/{year}"

    ourbus_location_id = {
        "ithaca":"Ithaca,%20NY",
        "new_york":"New%20York,%20NY",
    }

    web = urllib.request.urlopen(f"https://www.ourbus.com/booknow?origin={ourbus_location_id[dep_loc]}&destination={ourbus_location_id[arr_loc]}&departure_date={proper_date}&adult=1")
    soup = BeautifulSoup(web.read(), 'lxml')

    # Get the 35th script tag as a string, split by new line, get var default search line which is line 44, 
    # create json starting from character 21
    # Have to do this since the request returns HTML and not JSON
    data  = soup.find_all("script")[35].string.splitlines()[44][21:-2]
    loaded_data = json.loads(data)['searchedRouteList']['list']

    for index in range(len(loaded_data)):
        try:
            journey = loaded_data[index]
            trip_date = journey['travel_date']
            price = journey['pass_amount']
            arr_time = journey['last_stop_eta']
            arr_location = journey['dest_landmark']
            departure_time = journey['start_time']
            departure_location = journey['src_landmark']
            bus = "OurBus"
            non_stop = journey['non_stop']

            newTrip = Trip(date=trip_date, price=price, arr_time=arr_time, arr_location=arr_location, dep_time=departure_time, dep_location=departure_location, bus_serivce=bus, non_stop=non_stop)
            trips['trips'].append(newTrip)
        except:
            continue
    
    # for trip in trips["trips"]:
    #     print(trip)


# MegaBus
# Date Format: 2023-12-18
def get_mega_bus(date, dep_loc, arr_loc):
    mega_location_id = {
        "511":"Ithaca",
        "ithaca":"511",
        "123":"New York",
        "new_york": "123"
    }
    month = date[:2]
    day = date[3:5]
    year = date[6:]
    proper_date = f"{year}-{month}-{day}"

    mega_request = requests.get(f"https://us.megabus.com/journey-planner/api/journeys?originId={mega_location_id[dep_loc]}&destinationId={mega_location_id[arr_loc]}&departureDate={proper_date}&totalPassengers=1&concessionCount=0&nusCount=0&otherDisabilityCount=0&wheelchairSeated=0&pcaCount=0&days=1")
    mega_response = json.loads(mega_request.text)
    mega_info = mega_response['journeys']

    for journey in mega_info:
        journey_dep_date_time = journey['departureDateTime'].split("T")
        journey_arr_date_time = journey['arrivalDateTime'].split("T")
        
        date = journey_dep_date_time[0]
        price = journey['price']
        arr_time = journey_arr_date_time[1]
        arr_location = journey['destination']['stopName']
        departure_time = journey_dep_date_time[1]
        departure_location = journey['origin']['stopName']
        bus = "Mega"

        newTrip = Trip(date=date, price=price, arr_time=arr_time, arr_location=arr_location, dep_time=departure_time, dep_location=departure_location, bus_serivce=bus)

        # Add new trip to all trips to respond with 
        trips['trips'].append(newTrip)
        
    # for trip in trips["trips"]:
    #     print(trip)


# FlixBus
# Date Format: day.month.year
def get_flix_bus(date, dep_loc, arr_loc):
    flix_location_id = {
        "99c4f86c-3ecb-11ea-8017-02437075395e": "Ithaca",
        "c0a47c54-53ea-46dc-984b-b764fc0b2fa9": "New York",
        "ithaca": "99c4f86c-3ecb-11ea-8017-02437075395e",
        "new_york": "c0a47c54-53ea-46dc-984b-b764fc0b2fa9"
    }
   
    month = date[:2]
    day = date[3:5]
    year = date[6:]
    proper_date = f"{day}.{month}.{year}"

    flix_request = requests.get(f"https://global.api.flixbus.com/search/service/v4/search?from_city_id={flix_location_id[dep_loc]}&to_city_id={flix_location_id[arr_loc]}&departure_date={proper_date}&products=%7B%22adult%22%3A1%7D&currency=USD&locale=en_US&search_by=cities&include_after_midnight_rides=1")
    flix_response = json.loads(flix_request.text)
    flix_info = flix_response['trips'][0]['results']

    for uid in flix_info:
        status = flix_info[uid]['status']
    #    don't care abt the posting if it's not available 
        if status != 'available':
            continue
        else:
            departure_string = flix_info[uid]['departure']['date'].split("T")
            departure_city = flix_location_id[flix_info[uid]['departure']['city_id']]
            departure_date = departure_string[0]
            departure_time = departure_string[1][:5]
            arrival_string = flix_info[uid]['arrival']['date'].split("T")
            arrival_city = flix_location_id[flix_info[uid]['arrival']['city_id']]
            arrival_time = arrival_string[1][:5]
            bus_service = 'flixbus'
            price = flix_info[uid]['price']['total']

            newTrip = Trip(date=departure_date, price=price, arr_time=arrival_time, arr_location=arrival_city, dep_time=departure_time, dep_location=departure_city, bus_serivce=bus_service)

            # Add new trip to all trips to respond with 
            trips['trips'].append(newTrip)
        
    # for trip in trips["trips"]:
    #     print(trip)


def get_all(date, dep_loc, arr_loc):
    # Call each service
    get_flix_bus(date=date, dep_loc=dep_loc, arr_loc=arr_loc)
    get_mega_bus(date=date, dep_loc=dep_loc, arr_loc=arr_loc)
    get_our_bus(date=date, dep_loc=dep_loc, arr_loc=arr_loc)

    # loop through each trip first time
    to_return = []
    for trip in trips['trips']:
        to_return.append(trip)

    # sort trips based on first loop through and print sorted list
    to_return.sort(key=lambda x: x.price)
    for trip_2 in to_return:
        print(trip_2)
