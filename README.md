# **GetMeHome**

<img src="/screenshots/logo.png" alt="GetMeHome Icon" title="GetMeHome Icon" height = "120" width = "120">

To make it easier to get home on school breaks, I developed GetMeHome, a fullstack iOS project that aggregates trip information across MegaBus, FlixBus, and OurBus. Users enter in a travel date, departure city, and destination city and are returned a list of trips from each service sorted in increasing order of price. Users can further refine their search by selecting the earliest departure time, latest arrival time, or neither.

- A sample response can be found in the file sample_response.json

**Backend**:

- Technologies: Python, Postman
- Modules and Packages: Flask, Requests, BeautifulSoup, json
- Hosted API on Render platform

**Frontend**:

- Technologies: Swift, SwiftUI, MapKit
- Features:

  - Select date of trip, origin, and destination and search for corresponding trips
  - Filter based on earliest departure, latest arrival, bus service, bus transferring or none
  - View intermediate stops and full route the bus will take
  - Get link to buy ticket from respective services website
  - Get discount codes (OurBus only at the moment)
  - See trip departure and destination location on map (FlixBus only at the moment)

**What I Learned**:

- Scraping HTML pages with BeautifulSoup
- Processing JSON information
- Making a REST API with Flask
- Connecting iOS app to an API and dynamically populating views from JSON response
- Filtering data from JSON response in Swift

**Challenges**:

- Had to scrape HTML for OurBus information then convert it to JSON
- Working with data from with three different data services and consolidating them into one data type
- Deciding when to handle logic on the frontend or backend. I ended up choosing the frontend more often because it would reduce the complexity
  my routes and API
- MegaBus's API was down for almost an entire day during the development of V1

**Current Screenshots of App**

Youtube Video Demo Link: https://youtu.be/nQvyMH7IZIA

<img src="/screenshots/ss_1.png" width="23%"></img> <img src="/screenshots/ss_2.png" width="23%"></img> <img src="/screenshots/ss_3.png" width="23%"></img> <img src="/screenshots/ss_4.png" width="23%"></img> <img src="/screenshots/ss_5.png" width="23%"></img> <img src="/screenshots/ss_6.png" width="23%"></img> <img src="/screenshots/ss_7.png" width="23%"></img> <img src="/screenshots/ss_8.png" width="23%"></img>
