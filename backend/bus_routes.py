import requests
import json
from bs4 import BeautifulSoup
import urllib
import jsonpickle 
from datetime import datetime
from random import randrange
import exceptions

"""
Bus Routes:

This module sends a request to MegaBus, Flixbus, and OurBus 
APIs and returns the trips for a given date, departure location,
and arrival location from each service.

Inputs:
- Dates:
    - must be input in format: "MM-DD-YYYY"
    - first 2 characters are month, second two are day, and last 4 are year
- Locations 
    - ithaca for "Ithaca"
    - new_york for "New York"

Output:
Returns a list of Trip objects in ascending order of price
"""

class Trip:
    def __init__(
            self, 
            random_num, 
            date, 
            price, 
            arr_time, 
            arr_location, 
            dep_time, 
            dep_location, 
            bus_serivce, 
            ticket_link, 
            non_stop="N/A", 
            intermediate_count=0, 
            intermediate_stations = [],
            ):
        
        self.random_num = random_num
        self.date = date
        self.price = price
        self.arrival_time = arr_time
        self.arrival_location = arr_location
        self.departure_time = dep_time
        self.departure_location = dep_location
        self.bus_service = bus_serivce
        self.non_stop = non_stop
        self.ticket_link = ticket_link
        self.intermediate_count = intermediate_count
        self.intermediate_stations = intermediate_stations
    
    def __str__(self) -> str:
        return f"date: {self.date}, price: {self.price}, dep: {self.departure_time} @ {self.departure_location}, arr:{self.arrival_time} @ {self.arrival_location}, bus: {self.bus_service}, non-stop:{self.non_stop}"
    
def format_date(search_date, bus_service):
    # Checking for '-' between dates
    try:
        date_info = search_date.split('-')
    except:
        raise exceptions.IncorrectDateFormatException
   
    month = date_info[0]
    day = date_info[1]
    year = date_info[2]

    if len(month) != 2 or len(day) != 2 or len(year) != 4:
        raise exceptions.IncorrectDateFormatException

    if len(search_date) != 10:
        raise exceptions.IncorrectDateFormatException
    
    # Check that date is not in past
    search_date_string = datetime(int(year),int(month),int(day))
    current_date_day = datetime.now().day
    current_date_month = datetime.now().month
    current_date_year = datetime.now().year
    current_date_string = datetime(current_date_year, current_date_month, current_date_day)
    
    if search_date_string < current_date_string and search_date_string != current_date_string:
        raise exceptions.PastDateException
    
    if bus_service == "flix":
        return f"{day}.{month}.{year}"
    if bus_service == "mega":
        return f"{year}-{month}-{day}"
    if bus_service == "our":
        return f"{month}/{day}/{year}"

# OurBus
def get_our_bus(date,dep_loc,arr_loc, all_or_single):
    result = []
    proper_date = format_date(search_date=date, bus_service="our")
    ourbus_location_id = {
        "ithaca":"Ithaca,%20NY",
        "new_york":"New%20York,%20NY",
        "syracuse": "Syracuse,%20NY"
    }

    try:
        api_and_ticket_link = f"https://www.ourbus.com/booknow?origin={ourbus_location_id[dep_loc]}&destination={ourbus_location_id[arr_loc]}&departure_date={proper_date}&adult=1"
        web = urllib.request.urlopen(api_and_ticket_link)
        soup = BeautifulSoup(web.read(), 'lxml')

        # Code to find script tag with variable defaultSearch since this contains the trips
        # 1. Find all script tags in response and go through each until I find the tag containing "var defaultSearch" 
        # 2. Go through the lines of the found tag and get the exact line of defaultSearch
        # 3. Remove extra characters and spacing to make it into JSON -> [21:-2]

        data = soup.find_all("script")
        for tag in data:
            # check if tag is non empty
            if tag.string:
                # check script tag for defaultSearch
                if "var defaultSearch" in tag.string:
                    lines = tag.string.splitlines()
                    for line in lines:
                        # get the exact defaultSearch line as a string
                        if "var defaultSearch" in str(line):
                            parsed_trips = line[21:-2]
                            break
        # Trip List Data
        loaded_data = json.loads(parsed_trips)['searchedRouteList']['list']

        # Discount Code Loaded Data
        discount_code_loaded_data = json.loads(parsed_trips)['searchedRouteList']['voucher']

    except Exception as e:
        raise e
    else:
        # Discount Codes
        discount_codes = []
        for index in range(len(discount_code_loaded_data)):
            discount_code = discount_code_loaded_data[index]
            discount_code_name = discount_code['voucher_name']
            random_num_id = randrange(10000)
            discount_codes.append(
                {
                    "id": random_num_id,
                    "service": "OurBus",
                    "code": f"{discount_code_name}"
                }
            )

        # Basic Trip Information
        for index in range(len(loaded_data)):
            journey = loaded_data[index]
            # skip sold out bus or non direct buses

            if journey['trip_status'] == "STOP_SALES":
                continue
            else:
                trip_date = journey['travel_date']
                price = journey['pass_amount']
                arr_time = journey['last_stop_eta']
                arr_time_12h = datetime.strptime(arr_time, "%H:%M:%S")
                arr_time_12h = arr_time_12h.strftime("%I:%M %p")
                arr_location = journey['dest_landmark']
                departure_time = journey['start_time']
                dep_time_12h = datetime.strptime(departure_time, "%H:%M:%S")
                dep_time_12h = dep_time_12h.strftime("%I:%M %p")
                departure_location = journey['src_landmark']
                bus = "OurBus"
                non_stop = str(journey['non_stop'])
                random_num = randrange(10000)
                route_id = journey['route_id']
                try:
                    # Intermediate Stations Request and Information
                    intermediate_stations_link = f"https://www.ourbus.com/stopList/{route_id}"
                    intermediate_stations_request = requests.get(intermediate_stations_link)
                    intermediate_stations_response = json.loads(intermediate_stations_request.text)
                    intermediate_stations_info = intermediate_stations_response["stopList"]
                    intermediate_count = len(intermediate_stations_info) 
                
                    intermediate_stations_names = []
                    for index in range(0,intermediate_count):
                        city_and_location = f"{index+1}. {intermediate_stations_info[index]['stop_name']} \n{intermediate_stations_info[index]['landmark']}"
                        intermediate_stations_names.append(city_and_location)
            
                except:
                    intermediate_count = 0
                    intermediate_stations_names = []

                newTrip = Trip(intermediate_stations=intermediate_stations_names, 
                               intermediate_count=intermediate_count - 2, 
                               ticket_link=api_and_ticket_link, 
                               random_num=random_num,date=trip_date, 
                               price=price, arr_time=arr_time_12h, 
                               arr_location=arr_location, 
                               dep_time=dep_time_12h, 
                               dep_location=departure_location, 
                               bus_serivce=bus, 
                               non_stop=non_stop)
                result.append(newTrip)
          
        if all_or_single:
            return {
                "trips": result,
                "discount_codes": discount_codes
            }
        else:
            result.sort(key=lambda x: x.price)
            trips_and_codes =  {
                "trips": result,
                "discount_codes": discount_codes
            }
            return jsonpickle.encode(trips_and_codes)
# MegaBus
def get_mega_bus(date, dep_loc, arr_loc, all_or_single):
    result = []
    discount_codes = []

    mega_location_id = {
        "511":"Ithaca",
        "123":"New York",
        "139":"Syracuse",

        "syracuse":"139",
        "ithaca":"511",
        "new_york": "123"
    }
    proper_date = format_date(search_date=date, bus_service="mega")

    ticket_link = f"https://us.megabus.com/journey-planner/journeys?days=1&concessionCount=0&departureDate={proper_date}&destinationId={mega_location_id[arr_loc]}&inboundOtherDisabilityCount=0&inboundPcaCount=0&inboundWheelchairSeated=0&nusCount=0&originId={mega_location_id[dep_loc]}&otherDisabilityCount=0&pcaCount=0&totalPassengers=1&wheelchairSeated=0"
    try:
        mega_request = requests.get(f"https://us.megabus.com/journey-planner/api/journeys?originId={mega_location_id[dep_loc]}&destinationId={mega_location_id[arr_loc]}&departureDate={proper_date}&totalPassengers=1&concessionCount=0&nusCount=0&otherDisabilityCount=0&wheelchairSeated=0&pcaCount=0&days=1")
        mega_response = json.loads(mega_request.text)
        mega_info = mega_response['journeys']
    
    except Exception as e:
        raise e
    
    else:
        for journey in mega_info:
            journey_dep_date_time = journey['departureDateTime'].split("T")
            journey_arr_date_time = journey['arrivalDateTime'].split("T")
            
            date = journey_dep_date_time[0]
            price = journey['price']
            arr_time = journey_arr_date_time[1]
            arr_time_12h = datetime.strptime(arr_time, "%H:%M:%S")
            arr_time_12h = arr_time_12h.strftime("%I:%M %p")

            arr_location = journey['destination']['stopName']
            departure_time = journey_dep_date_time[1]
            dep_time_12h = datetime.strptime(departure_time, "%H:%M:%S")
            dep_time_12h = dep_time_12h.strftime("%I:%M %p")
            departure_location = journey['origin']['stopName']
            bus = "MegaBus"
            random_num = randrange(10000)
            journey_id = journey["journeyId"]

            non_stop = "N/A"
            leg_information = journey['legs']
            if len(leg_information) > 1:
                non_stop = "False"
            else:
                non_stop = "True"

            # Make request to get intermediate stop information
            try:
                intermediate_stations_link = f"https://us.megabus.com/journey-planner/api/itinerary?journeyId={journey_id}"
                intermediate_stations_request = requests.get(intermediate_stations_link)
                intermediate_stations_response = json.loads(intermediate_stations_request.text)
                intermediate_stations_info = intermediate_stations_response["scheduledStops"]
                intermediate_count = len(intermediate_stations_info) 
                
                intermediate_stations_names = []
                for index in range(0,intermediate_count):
                    city_and_location = f"{index+1}. {intermediate_stations_info[index]['cityName']} \n{intermediate_stations_info[index]['location']}"
                    intermediate_stations_names.append(city_and_location)
            except:
                intermediate_count = 0
                intermediate_stations_names = []

            newTrip = Trip(non_stop=non_stop,
                           intermediate_stations=intermediate_stations_names,
                           intermediate_count=intermediate_count - 2,
                           ticket_link=ticket_link, 
                           random_num=random_num, 
                           date=date, price=price, 
                           arr_time=arr_time_12h, 
                           arr_location=arr_location, 
                           dep_time=dep_time_12h, 
                           dep_location=departure_location, 
                           bus_serivce=bus)
            result.append(newTrip)

        if all_or_single:
            return {
                "trips": result,
                "discount_codes": discount_codes
            }
        else:
            result.sort(key=lambda x: x.price)
            trips_and_codes =  {
                "trips": result,
                "discount_codes": discount_codes
            }
            return jsonpickle.encode(trips_and_codes)

# FlixBus
def get_flix_bus(date, dep_loc, arr_loc, all_or_single):
    result = []
    discount_codes = []
    flix_location_id = {
        "ithaca": "99c4f86c-3ecb-11ea-8017-02437075395e",
        "new_york": "c0a47c54-53ea-46dc-984b-b764fc0b2fa9",
        "syracuse": "270aeb05-d99f-4cc0-a578-724339024c87",

        "270aeb05-d99f-4cc0-a578-724339024c87": "Syracuse",
        "99c4f86c-3ecb-11ea-8017-02437075395e": "Ithaca",
        "9b6aadb6-3ecb-11ea-8017-02437075395e": "131 E Green St",
        "ddf85f3f-f4ac-45e7-b439-1c31ed733ce1": "NYC Midtown (31st St & 8th Ave)",
        "e204bb66-8ab9-4437-8d0d-2b603cdf0c43": "New York Port Authority",
        "c0a47c54-53ea-46dc-984b-b764fc0b2fa9": "New York",
        "ddf85f3f-f4ac-45e7-b439-1c31ed733ce1": "NYC Midtown (31st St & 8th Ave)",
    }
   
    proper_date = format_date(search_date=date, bus_service="flix")
    link = f"https://global.api.flixbus.com/search/service/v4/search?from_city_id={flix_location_id[dep_loc]}&to_city_id={flix_location_id[arr_loc]}&departure_date={proper_date}&products=%7B%22adult%22%3A1%7D&currency=USD&locale=en_US&search_by=cities&include_after_midnight_rides=1"
    try:
        flix_request = requests.get(link)
        flix_response = json.loads(flix_request.text)
        flix_info = flix_response['trips'][0]['results']

    except Exception as e:
        raise e
    
    else:
        ticket_link = f"https://shop.flixbus.com/search?departureCity={flix_location_id[dep_loc]}&arrivalCity={flix_location_id[arr_loc]}&rideDate={proper_date}&adult=1&_locale=en_US&features%5Bfeature.enable_distribusion%5D=1&features%5Bfeature.train_cities_only%5D=0&features%5Bfeature.auto_update_disabled%5D=0&features%5Bfeature.webc_search_station_suggestions_enabled%5D=0&features%5Bfeature.darken_page%5D=1"

        for uid in flix_info:
            status = flix_info[uid]['status']
            transfer_type = flix_info[uid]['transfer_type']

            non_stop = "N/A"
            if transfer_type == "Direct":
                non_stop = "True"
            else:
                non_stop = "False"

        #    don't care abt the posting if it's not available 
            if status != 'available':
                continue
            else:
                departure_string = flix_info[uid]['departure']['date'].split("T")
                departure_city = flix_location_id[flix_info[uid]['departure']['station_id']]
                departure_date = departure_string[0]
                departure_time = departure_string[1][:5]
                dep_time_12h = datetime.strptime(departure_time, "%H:%M")
                dep_time_12h = dep_time_12h.strftime("%I:%M %p")
                arrival_string = flix_info[uid]['arrival']['date'].split("T")
                arrival_city = flix_location_id[flix_info[uid]['arrival']['station_id']]
                arrival_time = arrival_string[1][:5]
                arr_time_12h = datetime.strptime(arrival_time, "%H:%M")
                arr_time_12h = arr_time_12h.strftime("%I:%M %p")
                bus_service = 'FlixBus'
                price = flix_info[uid]['price']['total']
                random_num = randrange(10000)

                # Make request to get intermediate stop information
                # There is only intermediate stop information for Direct Trips
                if transfer_type == "Direct":
                    try:
                        intermediate_count = flix_info[uid]['intermediate_stations_count']
                        uid_string_replace_colons = uid_string.replace(":","%3A")
                        intermediate_stations_link = f"https://global.api.flixbus.com/search/service/v2/trip/details?locale=en_US&trip={uid_string_replace_colons}"
                        intermediate_stations_request = requests.get(intermediate_stations_link)
                        intermediate_stations_response = json.loads(intermediate_stations_request.text)
                        intermediate_stations_info = intermediate_stations_response["itinerary"][0]["segments"]
                        intermediate_count = len(intermediate_stations_info) 
                        intermediate_stations_names = []
                        for index in range(0,intermediate_count):
                            city_name = f"{index + 1}. {intermediate_stations_info[index]['name']}"
                            intermediate_stations_names.append(city_name)
                    except:
                        intermediate_stations_names = []
                        intermediate_count = 0
                else:
                    try:
                        uid_string = flix_info[uid]['uid']
                        uid_string_replace_colons = uid_string.replace(":","%3A")
                        uid_string_final = uid_string_replace_colons.replace("/", "%2F")
                        intermediate_stations_link = f"https://global.api.flixbus.com/search/service/v2/trip/details?locale=en_US&trip={uid_string_final}"
                        intermediate_stations_request = requests.get(intermediate_stations_link)
                        intermediate_stations_response = json.loads(intermediate_stations_request.text)

                        # iterate through transfers and add that to intermediate stations names
                        intermediate_count = 0 
                        intermediate_stations_names = []
                        
                        for item in intermediate_stations_response['itinerary']:
                            if item['type'] == "ride":
                                for segment in item['segments']:
                                    city_name = f"{segment['name']}"
                                    intermediate_stations_names.append(city_name)
                            if item['type'] == 'transfer':
                                time = f"{item['duration']['hours']} hr {item['duration']['minutes']} m"
                                transfer_city = item['station']['city_name']
                                intermediate_stations_names.append(f"Transfer @ {transfer_city} for {time}")
                                intermediate_count += 1
                        # Subtract 2 when I create the trip so I add back to here
                        intermediate_count += 2
                    except:
                            intermediate_stations_names = []
                            intermediate_count = 0
                
                newTrip = Trip(non_stop=non_stop,
                               intermediate_stations=intermediate_stations_names, 
                               intermediate_count=intermediate_count - 2,
                               ticket_link=ticket_link,
                               random_num=random_num,
                                date=departure_date, 
                                price=price, arr_time=arr_time_12h, 
                                arr_location=arrival_city,
                                dep_time=dep_time_12h, 
                                dep_location=departure_city, 
                                bus_serivce=bus_service)
                result.append(newTrip)
            
        # Dont want to wrap in json if its in the get all function
        # Also don't want to sort it since it will be sorted again with the other services
        if all_or_single:
            return {
                "trips": result,
                "discount_codes": discount_codes
            }
        else:
            result.sort(key=lambda x: x.price)
            trips_and_codes =  {
                "trips": result,
                "discount_codes": discount_codes
            }

            return jsonpickle.encode(trips_and_codes)

def get_all(date, dep_loc, arr_loc):
    # Call each service
    try:
        flix_trips = get_flix_bus(date=date, dep_loc=dep_loc, arr_loc=arr_loc, all_or_single=True)
        mega_trips = get_mega_bus(date=date, dep_loc=dep_loc, arr_loc=arr_loc, all_or_single=True)
        our_bus_trips = get_our_bus(date=date, dep_loc=dep_loc, arr_loc=arr_loc, all_or_single=True)
    except Exception as e:
        raise e
    else:
        # Combining Three Lists Into A Single list Using '+'
        trips = flix_trips['trips'] + mega_trips['trips'] + our_bus_trips['trips']
        trips.sort(key=lambda x: x.price)

        discount_codes = flix_trips['discount_codes'] + mega_trips['discount_codes'] + our_bus_trips['discount_codes']
        
        print(f"Total Options: {len(trips)}")
        print(f"Cheapest Trip: {trips[0]}")
        
        trips_and_codes =  {
            "trips": trips,
            "discount_codes": discount_codes
        }

        return jsonpickle.encode(trips_and_codes)

