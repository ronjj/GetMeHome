# **GetMeHome**

GetMeHome aggregates trip information across MegaBus, FlixBus, and OurBus. I was motivated to create this package after booking trips to travel from Ithaca, NY to New York City. To make the process easier I developed GetMeHome.

V1 was built in a couple days during my Thanksgiving break. Plan to expand locations, backend routes, and add a front end in the future.

- A sample response can be found in the file sample_response_v1.json

**Backend**:

- Technologies: Python, Postman
- Modules and Packages: Requests, BeautifulSoup, json

**What I Learned**:

- Scraping HTML pages with BeautifulSoup
- Processing JSON information
- Making a REST API with Flask

**Challenges**:

- Had to scrape HTML for OurBus information then convert it to JSON
