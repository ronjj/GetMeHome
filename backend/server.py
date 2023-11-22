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
    return render_template("/frontend/index.html")

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


# Run Server
if __name__ == '__main__':
    app.run(debug=True)