from flask import Flask, render_template
import os
import bus_routes
import json


# Initialise Flask App
app = Flask(__name__)
basedir = os.path.abspath(os.path.dirname(__file__))

def create_app():
    app = Flask(__name__)
    app.config.from_object("project.config")

    return app


# Get All Trips for A Date, Origin, and Destination
@app.route('/all/<date>/<origin>/<destination>', methods=["GET"])
def get_trips(date, origin, destination):
    trips = bus_routes.get_all(date=date, dep_loc=origin, arr_loc=destination)
    return trips

# OurBus
@app.route('/our/<date>/<origin>/<destination>', methods=["GET"])
def get_our_bus_trips(date, origin, destination):
    trips = bus_routes.get_our_bus(date=date, dep_loc=origin, arr_loc=destination)
    return trips

# Mega
@app.route('/mega/<date>/<origin>/<destination>', methods=["GET"])
def get_mega_trips(date, origin, destination):
    trips = bus_routes.get_mega_bus(date=date, dep_loc=origin, arr_loc=destination)
    return trips

# Flix
@app.route('/flix/<date>/<origin>/<destination>', methods=["GET"])
def get_flix_trips(date, origin, destination):
    trips = bus_routes.get_flix_bus(date=date, dep_loc=origin, arr_loc=destination)
    return trips

# Min Time Routes
# ------------------------------

# Get All Trips for A Date, Origin, and Destination given a min time
@app.route('/all/<date>/<origin>/<destination>/<min>', methods=["GET"])
def get_trips_min_time(date, origin, destination, min):
    trips = bus_routes.get_all_min_time(date=date, dep_loc=origin, arr_loc=destination, min_time=min)
    return trips

# OurBus Min
@app.route('/our/<date>/<origin>/<destination>/<min>', methods=["GET"])
def get_our_bus_trips_min(date, origin, destination,min):
    trips = bus_routes.get_our_bus_min(date=date, dep_loc=origin, arr_loc=destination,min=min)
    return trips

# Mega Min
@app.route('/mega/<date>/<origin>/<destination>/<min>', methods=["GET"])
def get_mega_bus_trips_min(date, origin, destination,min):
    trips = bus_routes.get_mega_bus_min(date=date, dep_loc=origin, arr_loc=destination,min=min)
    return trips

# FlixBus Min
@app.route('/flix/<date>/<origin>/<destination>/<min>', methods=["GET"])
def get_flix_bus_trips_min(date, origin, destination,min):
    trips = bus_routes.get_flix_bus_min(date=date, dep_loc=origin, arr_loc=destination,min=min)
    return trips



# Run Server
if __name__ == '__main__':
    app.run(debug=True)