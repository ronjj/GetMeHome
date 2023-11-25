# **GetMeHome**

To make it easier to get home on school breaks, I developed GetMeHome, a fullstack iOS project that aggregates trip information across MegaBus, FlixBus, and OurBus. Users enter in a travel date, departure city, and destination city and are returned a list of trips from each service sorted in increasing order of price.

- V1 was built in a few days during my Thanksgiving break. Plan to expand locations, backend routes, and add a more robust front end in the future.

- A sample response can be found in the file sample_response_v1.json

**Backend**:

- Technologies: Python, Postman
- Modules and Packages: Requests, BeautifulSoup, json

**Frontend**:

- Technologies: Swift, SwiftUI

**What I Learned**:

- Scraping HTML pages with BeautifulSoup
- Processing JSON information
- Making a REST API with Flask
- Connecting iOS app to an API and dynamically populating views from JSON response

**Challenges**:

- Had to scrape HTML for OurBus information then convert it to JSON

**Current Screenshots of App and Backend**

<img src="/screenshots/ss_1.png" alt="home screen" title="home screen" height = "694" width = "321">

<img src="/screenshots/ss_2.png" alt="calendar" title="calendar" height = "694" width = "321">

<img src="/screenshots/ss_3.png" alt="loading" title="loading" height = "694" width = "321">

<img src="/screenshots/ss_4.png" alt="list of results " title="list of results" height = "694" width = "321">

<img src="/screenshots/ss_5.png" alt="list of results" title="list of results" height = "694" width = "321">

<img src="/screenshots/ss_6.png" alt="detail view" title="detail view" height = "694" width = "321">

<img src="/screenshots/backend_response_v1.png" alt="backend response" title="backend response v1" height = "30" width = "500">
