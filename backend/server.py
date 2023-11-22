from flask import Flask
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
@app.route('/<date>/<origin>/<destination>', methods=["GET"])
def get_trips(date, origin, destination):
    trips = bus_routes.get_all(date=date, dep_loc=origin, arr_loc=destination)
    print(trips)
    return trips


# Run Server
if __name__ == '__main__':
    app.run(debug=True)