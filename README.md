# **GetMeHome**

To make it easier to get home on school breaks, I developed GetMeHome, a fullstack iOS project that aggregates trip information across MegaBus, FlixBus, and OurBus. Users enter in a travel date, departure city, and destination city and are returned a list of trips from each service sorted in increasing order of price. Users can further refine their search by selecting the earliest departure time, latest arrival time, or neither.

- V1: Built in 5 days during my Thanksgiving break.
- V2 Plans:

  - Clean up backend and front end code
  - Tests
  - Alerts for failed requests and a description.

- A sample response can be found in the file sample_response_v1.json

**Backend**:

- Technologies: Python, Postman
- Modules and Packages: Flask, Requests, BeautifulSoup, json
- Hosted API on Render platform

**Frontend**:

- Technologies: Swift, SwiftUI
- Features:

  - Select date of trip, origin, and destination
  - Select a bus service: MegaBus, OurBus, FlixBus, or all
  - Filter based on earliest departure, latest arrival, or neither
  - View intermediate stops and full route the bus will take (Mega and FlixBus) currently
  - Get link to buy ticket from respective services website

  - \*Trips that involve transferring buses are automatically skipped (FlixBus)
  - \*Trips that are not direct from city to city are automatically skipped (OurBus)

**What I Learned**:

- Scraping HTML pages with BeautifulSoup
- Processing JSON information
- Making a REST API with Flask
- Connecting iOS app to an API and dynamically populating views from JSON response

**Challenges**:

- Had to scrape HTML for OurBus information then convert it to JSON
- Working with data from with three different data services and consolidating them into one data type
- Deciding when to handle logic on the frontend or backend. I ended up choosing the frontend more often because it would reduce the complexity
  my routes and API
- MegaBus's API was down for almost an entire day during the development of V1

**Current Screenshots of App and Backend**

<img src="/screenshots/ss_1.png" width="23%"></img> <img src="/screenshots/ss_2.png" width="23%"></img> <img src="/screenshots/ss_3.png" width="23%"></img> <img src="/screenshots/ss_4.png" width="23%"></img> <img src="/screenshots/ss_5.png" width="23%"></img> <img src="/screenshots/ss_6.png" width="23%"></img> <img src="/screenshots/ss_7.png" width="23%"></img> <img src="/screenshots/ss_8.png" width="23%"></img>

<img src="/screenshots/backend_response_v1.png" alt="backend response" title="backend response v1" height = "30" width = "500">
