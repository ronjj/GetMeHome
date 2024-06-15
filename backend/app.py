from flask import Flask, request, make_response
import os
import bus_routes
import json
import exceptions
import constants
import asyncio
from flask_cors import CORS

# Initialise Flask App
app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}})  # This allows all domains for paths under /api
basedir = os.path.abspath(os.path.dirname(__file__))

def create_app():
    app = Flask(__name__)
    # app.config.from_object("project.config")
    return app

def error_message(message, code):
    return json.dumps({"message": f"{message}", "code" : f"{code}"})

# Get All Trips for A Date, Origin, Destination, and Bus Service
@app.route('/<bus_service>/<date>/<origin>/<destination>', methods=["GET"])
async def get_trips(bus_service, date, origin, destination):
    if request.method == "OPTIONS": # CORS preflight
      print("option request")
      return _build_cors_preflight_response()
    elif request.method == "GET":
        if bus_service not in constants.VALID_BUS_SERVICES:
            return error_message("Invalid Bus Service", constants.INVALID_REQUEST)
        if origin == destination:
            return error_message("Origin and Destination Cannot Be The Same", constants.INVALID_REQUEST)
        else:
            try:
                if bus_service == constants.ALL_BUSES:
                    trips = await bus_routes.get_all(date=date, dep_loc=origin, arr_loc=destination)
                if bus_service == constants.MEGA_BUS:
                    trips = await bus_routes.get_mega_bus(date=date, dep_loc=origin, arr_loc=destination, all_or_single=False)
                if bus_service == constants.OUR_BUS:
                    trips = await bus_routes.get_our_bus(date=date, dep_loc=origin, arr_loc=destination, all_or_single=False)
                if bus_service == constants.FLIX_BUS:
                    trips = await bus_routes.get_flix_bus(date=date, dep_loc=origin, arr_loc=destination, all_or_single=False)
            except exceptions.IncorrectDateFormatException:
                return error_message("Date formatting incorrect. Format is MM-DD-YYYY", constants.INVALID_REQUEST)
            except exceptions.PastDateException:
                return error_message("Cannot search for past dates. Must search for current or future date", constants.INVALID_REQUEST)
            except Exception as e:
                return error_message(f"{e}", constants.INTERNAL_SERVER_ERROR)
            else:
                resp = make_response(trips)
                resp.headers.add('Access-Control-Allow-Origin', '*')
                return resp
    else:
        return error_message("Invalid Request", constants.INVALID_REQUEST)
    
# Run Server
if __name__ == '__main__':
    asyncio.run(app.run(debug=True))
   
def _build_cors_preflight_response():
    response = make_response()
    response.headers.add("Access-Control-Allow-Origin", "*")
    response.headers.add('Access-Control-Allow-Headers', "*")
    response.headers.add('Access-Control-Allow-Methods', "*")
    return response