from flask import Flask
import os
import bus_routes
import json
import exceptions


# Initialise Flask App
app = Flask(__name__)
basedir = os.path.abspath(os.path.dirname(__file__))

def create_app():
    app = Flask(__name__)
    app.config.from_object("project.config")
    return app

def error_message(message, code):
    return json.dumps({"message": f"{message}", "code" : f"{code}"})

# Get All Trips for A Date, Origin, and Destination
@app.route('/all/<date>/<origin>/<destination>', methods=["GET"])
def get_trips(date, origin, destination):
    try:
        trips = bus_routes.get_all(date=date, dep_loc=origin, arr_loc=destination)
    except exceptions.IncorrectDateFormatException:
        return error_message("Date formatting incorrect. Format is MM-DD-YYYY", 400)
    except exceptions.PastDateException:
        return error_message("Cannot search for past dates. Must search for current or future date", 400)
    except Exception as e:
        return error_message(f"{e}", 500)
    else:
        return trips

# OurBus
@app.route('/our/<date>/<origin>/<destination>', methods=["GET"])
def get_our_bus_trips(date, origin, destination):
    try:
        trips = bus_routes.get_our_bus(date=date, dep_loc=origin, arr_loc=destination, all_or_single=False)
    except exceptions.IncorrectDateFormatException:
        return error_message("Date formatting incorrect. Format is MM-DD-YYYY", 400)
    except exceptions.PastDateException:
        return error_message("Cannot search for past dates. Must search for current or future date", 400)
    except Exception as e:
        return error_message(f"{e}", 500)
    else:
        return trips

# Mega
@app.route('/mega/<date>/<origin>/<destination>', methods=["GET"])
def get_mega_trips(date, origin, destination):
    try:
        trips = bus_routes.get_mega_bus(date=date, dep_loc=origin, arr_loc=destination, all_or_single=False)
    except exceptions.IncorrectDateFormatException:
        return error_message("Date formatting incorrect. Format is MM-DD-YYYY", 400)
    except exceptions.PastDateException:
        return error_message("Cannot search for past dates. Must search for current or future date", 400)
    except Exception as e:
        return error_message(f"{e}", 500)
    else:
        return trips

# Flix
@app.route('/flix/<date>/<origin>/<destination>', methods=["GET"])
def get_flix_trips(date, origin, destination):
    try:
        trips = bus_routes.get_flix_bus(date=date, dep_loc=origin, arr_loc=destination, all_or_single=False)
    except exceptions.IncorrectDateFormatException:
        return error_message("Date formatting incorrect. Format is MM-DD-YYYY", 400)
    except exceptions.PastDateException:
        return error_message("Cannot search for past dates. Must search for current or future date", 400)
    except Exception as e:
        return error_message(f"{e}", 500)
    else:
        return trips

# Run Server
if __name__ == '__main__':
    app.run(debug=True)