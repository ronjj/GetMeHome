# **GetMeHome**

GetMeHome aggregates trip information across MegaBus, FlixBus, and OurBus. I was motivated to create this package after booking trips to travel from Ithaca, NY to New York City. To make the process easier I developed GetMeHome.

V1 was built in a few days during my Thanksgiving break. Plan to expand locations, backend routes, and add a more robust front end in the future.

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
