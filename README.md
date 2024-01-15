# **GetMeHome**

<img src="/screenshots/logo.png" alt="GetMeHome Icon" title="GetMeHome Icon" height = "120" width = "120">

To make it easier to get home on school breaks, I developed GetMeHome, a fullstack iOS project that aggregates trip information across MegaBus, FlixBus, and OurBus. Users enter in a travel date, departure city, and destination city and are returned a list of trips from each service sorted in increasing order of price. Users can further refine their search by selecting the earliest departure time, latest arrival time, or neither.

- Current Locations: New York City, Ithaca, Syracuse, Syracuse Airport, Newark
- A sample response can be found in the file sample_response.json

**Backend**:

- Technologies: Python, Postman
- Modules and Packages: Flask, Requests, BeautifulSoup, json
- Hosted API on Render platform
- Features:

  - Get and aggredate data from OurBus,FlixBus, and MegaBus APIs

**Frontend**:

- Technologies: Swift, SwiftUI, MapKit, AppStorage(UserDefaults), CoreData, Firebase Auth, Firebase Analytics
- Features:

  - Select date of trip, origin, and destination and search for corresponding trips
  - Filter based on earliest departure, latest arrival, bus service, bus transferring or none
  - View intermediate stops and full route the bus will take
  - Get link to buy ticket from respective services website
  - Get discount codes (OurBus only at the moment)
  - Sign in with Google or Apple
  - See trip departure and destination location on map (FlixBus only at the moment)
  - Set default search settings in the profile view
  - Save trips for later

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

Youtube Video Demo Link: https://youtu.be/gxtlPc_PfLg

<img src="https://github.com/ronjj/GetMeHome/assets/37760008/8d88ee74-d899-41e4-9c89-be5994e5f8cf" width="23%"></img><img src="https://github.com/ronjj/GetMeHome/assets/37760008/42d0cd5f-64c4-4f46-8c1b-cb92b511873d" width="23%"></img><img src="https://github.com/ronjj/GetMeHome/assets/37760008/52e02d93-dd5c-4391-8977-386eeff4f1d3" width="23%"></img><img src="https://github.com/ronjj/GetMeHome/assets/37760008/05892b67-4405-4030-914e-ceab114471a1" width="23%"></img><img src="https://github.com/ronjj/GetMeHome/assets/37760008/496998d0-899c-4270-ba58-e973b1be7819" width="23%"></img><img src="https://github.com/ronjj/GetMeHome/assets/37760008/f577d913-f65f-4824-b189-bd27d6b5dc1c" width="23%"></img><img src="https://github.com/ronjj/GetMeHome/assets/37760008/c7dddf09-bfff-44b3-9001-eec2b33e3949" width="23%"></img><img src="https://github.com/ronjj/GetMeHome/assets/37760008/bfcbe8b5-eb0a-42fe-9c84-499c3b97f756" width="23%"></img><img src="https://github.com/ronjj/GetMeHome/assets/37760008/bb358828-04df-4514-8c7e-402b392a8ffe" width="23%"></img><img src="https://github.com/ronjj/GetMeHome/assets/37760008/428f4871-3eec-4825-8575-8d95c1d2c923" width="23%"></img>
