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

<img src="https://github.com/ronjj/GetMeHo![ss9](https://github.com/ronjj/GetMeHome/assets/37760008/236b1ced-7e32-474f-8593-7237bcc32ee1" width="23%"></img> <img src="https://github.com/ronjj/GetMeHome/assets/37760008/02a4c4fe-9baf-47ef-9dee-2c10239678b5" width="23%"></img> <img src="https://github.com/ronjj/GetMeHome/assets/37760008/a83035a8-aa58-4fe3-bf13-0e391334c502" width="23%"></img> <img src="https://github.com/ronjj/GetMeHome/assets/37760008/bd59acc7-92a5-4e5a-aa5c-19c2abcb237e" width="23%"></img> <img src="https://github.com/ronjj/GetMeHome/assets/37760008/4c9e67fe-f0f7-4be0-9980-2ce669a6da02" width="23%"></img> <img src="https://github.com/ronjj/GetMeHome/assets/37760008/179752a1-32d3-4479-86ca-56615f21e20e" width="23%"></img> <img src="https://github.com/ronjj/GetMeHome/assets/37760008/f2beacd6-9852-458e-b8f8-585bf3fa7812" width="23%"></img> <img src="https://github.com/ronjj/GetMeHome/assets/37760008/f8565b12-90b5-4ce8-8353-8d80de4c9661" width="23%"></img> <img src="https://github.com/ronjj/GetMeHome/assets/37760008/7e160721-37d0-4cae-bf7b-887b9cd9de85" width="23%"></img> <img src="https://github.com/ronjj/GetMeHome/assets/37760008/0a9d7da2-507f-490c-8326-40a9e9030f6b" width="23%"></img> <img src="https://github.com/ronjj/GetMeHome/assets/37760008/b178bff9-e7cf-431a-8072-bc2207b0c63e" width="23%"></img> <img src="https://github.com/ronjj/GetMeHome/assets/37760008/704b9363-d0a3-433e-8f7e-771cfef198e0" width="23%"></img>
