
# Bus Services
VALID_BUS_SERVICES = ["all", "flix", "mega", "our", "trailways"]
OUR_BUS = "our"
OUR_BUS_FULL = "OurBus"
MEGA_BUS = "mega"
MEGA_BUS_FULL = "MegaBus"
FLIX_BUS = "flix"
FLIX_BUS_FULL = "FlixBus"
ALL_BUSES = "all"
TRAILWAYS = "trailways"
TRAILWAYS_FULL = "Trailways"

# Request Codes
INVALID_REQUEST = 400
INTERNAL_SERVER_ERROR = 500

# Bus Service Search ID Dictionaries
OURBUS_LOCATION_IDS = {
  "ithaca":"Ithaca,%20NY",
  "new_york":"New%20York,%20NY",
  "syracuse": "Syracuse,%20NY",
  "syr_airport": "Syracuse%20Airport,%20NY",
  "newark": "Newark%2C%20NJ",
  "philly": "Philadelphia%2C%20PA",
  "binghamton": "Binghamton%2C%20NY",
  "rochester": "Rochester%2C%20NY",
  "baltimore": "Baltimore%2C%20MD",
  "boston": "Boston%2C%20MA&",
  "albany": "Albany%2C%20NY",
  "buffalo": "Buffalo%2C%20NY",
}

TRAILWAYS_LOCATION_IDS = {
    "new_york": "83be15f2-118b-45d9-839c-c92e841f10fd",
    "newark": "a2c5828d-bb99-47f1-9704-d421061009ab",


    "83be15f2-118b-45d9-839c-c92e841f10fd": "New York (P.A.B.T.)",
    "a2c5828d-bb99-47f1-9704-d421061009ab": "Newark",
}

TRAILWAYS_REQUEST_HEADERS = {
    "Content-Type": "application/json",
    "Cookie": "SESSION=MmE3OTA1MjktNGE3Yi00MTI2LThhNWQtZDFiMGU2ZTRiNWNl",
    "tds-api-key": "04BAD10F-3AD2-49CD-A8FE-28CF8D2BA0AB"
}

MEGA_LOCATION_IDS = {
  "rochester": "134",
  "binghamton":"93",
  "philly": "127",
  "newark": "610",
  "syracuse": "139",
  "ithaca": "511",
  "new_york": "123",
  "baltimore": "143",
  "boston": "94",
  "albany": "89",
  "buffalo": "95",
}

FLIX_LOCATION_IDS = {
  "ithaca": "99c4f86c-3ecb-11ea-8017-02437075395e",
  "new_york": "c0a47c54-53ea-46dc-984b-b764fc0b2fa9",
  "syracuse": "270aeb05-d99f-4cc0-a578-724339024c87",
  "newark": "f5987d0c-232d-4d9b-8112-4a834d0c7ebd",
  "philly": "fd509c08-0a3e-4a44-b933-79f4a9db13da",
  "binghamton": "f6368de4-a532-4caf-8564-d99e5138e5a7",
  "rochester": "9361f877-cc72-448c-8545-c1b0e86b4ce8",
  "baltimore": "ff6921c7-4746-4553-8ef8-3bb7f19fc2bd",
  "boston": "eeff627f-2fda-4e75-8468-783d47955b3a",
  "albany": "c9968a8a-e5be-422b-b7f3-32851e4dc823",
  "buffalo": "946a2820-dc2d-4098-8583-d36f6804f6b7",

  # Arrival Station IDs

  # Buffalo
  "946a2820-dc2d-4098-8583-d36f6804f6b7": "Buffalo, NY", 
  "9a1b39b7-d723-4cf7-85dd-a34e3521568c": "Buffalo, NY",

  # Albany
  "e610e851-1daf-4fc5-a236-0cb200f82fba": "Albany Bus Terminal",

  # Boston
  "9b6bfd56-3ecb-11ea-8017-02437075395e": "Boston South Station",
  "9b6c1745-3ecb-11ea-8017-02437075395e": "Brookline, MA",
  "9b6c1714-3ecb-11ea-8017-02437075395e": "Cambridge, MA",

  # Baltimore
  "ff6921c7-4746-4553-8ef8-3bb7f19fc2bd": "Baltimore, MD",
  "977a0446-537c-4503-a27e-edb8d2e39756": "Baltimore, MD",
  "12a2c399-a17f-44e2-8d1f-7655f95c2689": "Baltimore Downtown Bus Station",
  "9b6aadb6-3ecb-11ea-8017-02437075395e": "White Marsh Park N Ride",
  "d42f8c40-c275-460d-87e1-e95bc8f91a25":  "White Marsh Park N Ride",

  # Rochester
  "9361f877-cc72-448c-8545-c1b0e86b4ce8": "Rochester, NY",
  "990919e2-39d1-4ff0-849e-1639c19307c6": "Rochester, NY",

  # Binghamton
  "9caca472-eb38-45fd-a5f9-43894add57a8" : "Binghamton, NY",

  # Philly
  "2a9747a9-710b-4372-9a54-b018e1892baf": "Camden Walter Rand Trans Center",
  "c5a2ff48-f8f4-4bc5-aa61-9daf9d1fbf38": "Cherry Hill Mall, PA",
  "1889e282-7b9b-4a16-a729-dc5000bc1e29": "Philadelphia, PA",
  "8acd6a7d-3aa4-4ca0-bb72-a36fe6b68d4b" : "Philadelphia, PA",
  "0927b550-2b91-4953-b297-4c3cd9b312f3": "Philadelphia (Logan Square), PA",
  "4a71452b-9fed-4e98-a84a-9f4d1dcff9c3" : "Malvern, PA",
  "1889e282-7b9b-4a16-a729-dc5000bc1e29" : "Philadelphia, PA",
  "fd509c08-0a3e-4a44-b933-79f4a9db13da": "Philadelphia, PA",
  
  # Newark
  "96f408ea-c731-4fb3-a9d3-721f7cf31dd1": "Newark, NJ",
  "f5987d0c-232d-4d9b-8112-4a834d0c7ebd": "Newark, NJ",
 
  # SYR
  "270aeb05-d99f-4cc0-a578-724339024c87": "Syracuse, NY",

  # ITH
  "99c4f86c-3ecb-11ea-8017-02437075395e": "Ithaca, NY",
  "9b6aadb6-3ecb-11ea-8017-02437075395e": "131 E Green St",
  
  # NYC
  "e204bb66-8ab9-4437-8d0d-2b603cdf0c43": "New York Port Authority",
  "c0a47c54-53ea-46dc-984b-b764fc0b2fa9": "New York City",
  "ddf85f3f-f4ac-45e7-b439-1c31ed733ce1": "NYC Midtown (31st St & 8th Ave)",
  "9b850136-6cc5-4982-b6aa-5b7209f432c9": "Syracuse Bus Station",
  "74b8f0dc-56a2-4d1b-b0a4-abe9df30a007": "New York (GW Bridge)",
}