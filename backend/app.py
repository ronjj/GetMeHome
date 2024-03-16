from flask import Flask, request
import os
import bus_routes
import json
import exceptions
import constants

# Initialise Flask App
app = Flask(__name__)
basedir = os.path.abspath(os.path.dirname(__file__))

def create_app():
    app = Flask(__name__)
    app.config.from_object("project.config")
    return app

def error_message(message, code):
    return json.dumps({"message": f"{message}", "code" : f"{code}"})

# Get All Trips for A Date, Origin, Destination, and Bus Service
@app.route('/<bus_service>/<date>/<origin>/<destination>', methods=["GET"])
def get_trips(bus_service, date, origin, destination):
    if bus_service not in constants.VALID_BUS_SERVICES:
        return error_message("Invalid Bus Service", constants.INVALID_REQUEST)
    if origin == destination:
        return error_message("Origin and Destination Cannot Be The Same", constants.INVALID_REQUEST)
    else:
        try:
            if bus_service == constants.ALL_BUSES:
                trips = bus_routes.get_all(date=date, dep_loc=origin, arr_loc=destination)
            if bus_service == constants.MEGA_BUS:
                trips = bus_routes.get_mega_bus(date=date, dep_loc=origin, arr_loc=destination, all_or_single=False)
            if bus_service == constants.OUR_BUS:
                trips = bus_routes.get_our_bus(date=date, dep_loc=origin, arr_loc=destination, all_or_single=False)
            if bus_service == constants.FLIX_BUS:
                trips = bus_routes.get_flix_bus(date=date, dep_loc=origin, arr_loc=destination, all_or_single=False)
        except exceptions.IncorrectDateFormatException:
            return error_message("Date formatting incorrect. Format is MM-DD-YYYY", constants.INVALID_REQUEST)
        except exceptions.PastDateException:
            return error_message("Cannot search for past dates. Must search for current or future date", constants.INVALID_REQUEST)
        except Exception as e:
            return error_message(f"{e}", constants.INTERNAL_SERVER_ERROR)
        else:
            return trips

@app.route('/buy_ticket', methods=["POST"])
def buy_ticket():
    try:
        data = request.json
    except:
        return error_message("POST Request should contain valid JSON", constants.INVALID_REQUEST)
    else:
        name = data['name']
        email = data['email']
        bus_service = data['bus_service']
        date = data['date']
        origin = data['origin']
        destination = data['destination']
        ticket_price = data['ticket_price']
        commission = data['commission']
        link_to_buy = data['link_to_buy']

        print(f"Received Request: {data}")
        return f"successfully recieved {data}"
    
# Run Server
if __name__ == '__main__':
    app.run(debug=True)