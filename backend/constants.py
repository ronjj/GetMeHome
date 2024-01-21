
# Bus Services
VALID_BUS_SERVICES = ["all", "flix", "mega", "our"]
OUR_BUS = "our"
OUR_BUS_FULL = "OurBus"
MEGA_BUS = "mega"
MEGA_BUS_FULL = "MegaBus"
FLIX_BUS = "flix"
FLIX_BUS_FULL = "FlixBus"
ALL_BUSES = "all"

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
}

MEGA_LOCATION_IDS = {
  "511":"Ithaca",
  "123":"New York",
  "139":"Syracuse",
  "610": "Newark, NJ",
  "127": "Philadelphia, PA",

  "philly": "127",
  "newark": "610",
  "syracuse": "139",
  "ithaca": "511",
  "new_york": "123"
}

FLIX_LOCATION_IDS = {
  "ithaca": "99c4f86c-3ecb-11ea-8017-02437075395e",
  "new_york": "c0a47c54-53ea-46dc-984b-b764fc0b2fa9",
  "syracuse": "270aeb05-d99f-4cc0-a578-724339024c87",
  "newark": "f5987d0c-232d-4d9b-8112-4a834d0c7ebd",
  "philly": "fd509c08-0a3e-4a44-b933-79f4a9db13da",

  # Arrival Station IDs
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
  "270aeb05-d99f-4cc0-a578-724339024c87": "Syracuse",
  # ITH
  "99c4f86c-3ecb-11ea-8017-02437075395e": "Ithaca",
  "9b6aadb6-3ecb-11ea-8017-02437075395e": "131 E Green St",
  # NYC
  "e204bb66-8ab9-4437-8d0d-2b603cdf0c43": "New York Port Authority",
  "c0a47c54-53ea-46dc-984b-b764fc0b2fa9": "New York",
  "ddf85f3f-f4ac-45e7-b439-1c31ed733ce1": "NYC Midtown (31st St & 8th Ave)",
  "9b850136-6cc5-4982-b6aa-5b7209f432c9": "Syracuse Bus Station",
  "74b8f0dc-56a2-4d1b-b0a4-abe9df30a007": "New York (GW Bridge)",
}