# **GetMeHome**

<img src="/screenshots/logo.png" alt="GetMeHome Icon" title="GetMeHome Icon" height = "120" width = "120">

To make it easier to get home on school breaks, I developed GetMeHome, a fullstack iOS project that aggregates trip information across MegaBus, FlixBus, and OurBus. Users enter in a travel date, departure city, and destination city and are returned a list of trips from each service sorted in increasing order of price. Users can further refine their search by selecting the earliest departure time, latest arrival time, or neither.

- Locations: New York City, Ithaca, Syracuse, Syracuse Airport, Newark, Boston, Philadelphia, Rochester, Binghamton
- Youtube Video Demo Link: https://youtu.be/gxtlPc_PfLg
- App Store Link: https://apps.apple.com/us/app/getmehome-find-trips-home/id6476405163
- A sample response can be found in the file sample_response.json

**Backend**:

- Technologies: Python, Flask, BeautfiulSoup
- Hosted API on Render platform

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
