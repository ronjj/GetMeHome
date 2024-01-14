
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
}

MEGA_LOCATION_IDS = {
  "511":"Ithaca",
  "123":"New York",
  "139":"Syracuse",
  "610": "Newark, NJ",

  "newark":"610",
  "syracuse":"139",
  "ithaca":"511",
  "new_york": "123"
}

FLIX_LOCATION_IDS = {
  "ithaca": "99c4f86c-3ecb-11ea-8017-02437075395e",
  "new_york": "c0a47c54-53ea-46dc-984b-b764fc0b2fa9",
  "syracuse": "270aeb05-d99f-4cc0-a578-724339024c87",
  "newark": "f5987d0c-232d-4d9b-8112-4a834d0c7ebd",

  # Arrival Station IDs
  "f5987d0c-232d-4d9b-8112-4a834d0c7ebd": "Newark, NJ",
  "270aeb05-d99f-4cc0-a578-724339024c87": "Syracuse",
  "99c4f86c-3ecb-11ea-8017-02437075395e": "Ithaca",
  "9b6aadb6-3ecb-11ea-8017-02437075395e": "131 E Green St",
  "e204bb66-8ab9-4437-8d0d-2b603cdf0c43": "New York Port Authority",
  "c0a47c54-53ea-46dc-984b-b764fc0b2fa9": "New York",
  "ddf85f3f-f4ac-45e7-b439-1c31ed733ce1": "NYC Midtown (31st St & 8th Ave)",
  "9b850136-6cc5-4982-b6aa-5b7209f432c9": "Syracuse Bus Station",
  "74b8f0dc-56a2-4d1b-b0a4-abe9df30a007": "New York (GW Bridge)",
}