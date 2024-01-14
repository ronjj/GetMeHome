
from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy()

user_saved_trips = db.Table('user_saved_trips',
    db.Column('user_id', db.String(50), db.ForeignKey('user.id'), primary_key=True),
    db.Column('saved_trip_id', db.Integer, db.ForeignKey('savedtrip.id'), primary_key=True))

class SavedTrip(db.Model):
  """
  Trip Model For Saving
  """
  __tablename__ = "savedtrips"
  id = db.Column(db.Integer, primary_key=True)
  date = db.Column(db.String(50), nullable=False)
  time = db.Column(db.String(50), nullable=False)
  bus_service = db.Column(db.String(50), nullable=False)
  price = db.Column(db.Float, nullable=False)
  arr_time = db.Column(db.String(50), nullable=False)
  arr_loc = db.Column(db.String(1000), nullable=False)
  dep_time = db.Column(db.String(50), nullable=False)
  dep_loc = db.Column(db.String(1000), nullable=False)
  non_stop = db.Column(db.String(50), nullable=False)
  ticket_link = db.Column(db.String(100), nullable=False)
  intermediate_count = db.Column(db.Intger, nullable=False)
  intermediate_stations = db.Column(db.String(100), nullable=False)
  arr_loc_lat = db.Column(db.Float, nullable = False)
  arr_loc_long = db.Column(db.Float, nullable = False)
  dep_loc_lat = db.Column(db.Float, nullable = False)
  dep_loc_long = db.Column(db.Float, nullable = False)
  users = db.relationship('User', secondary=user_saved_trips)


class User(db.Model):
  id = db.Column(db.String(100), primary_key=True)

def save_trip(**kwargs):
  saved_trip = SavedTrip(
  )

  db.session.add(saved_trip)
  db.session.commit()
