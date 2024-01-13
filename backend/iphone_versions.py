"""
This file gets the Apple Device Model based on the identifier
Input: .txt file with list of identifiers and corresponding Device Names
Output: JSON file with same information

List From: https://gist.github.com/adamawolf/3048717

"""

import json

def txt_to_json(input_file):
  result = []
  with open(input_file) as text_file:
    lines = text_file.readlines()
    for line in lines:
      if ":" in line:
        split_line = line.split(":")
        identifier = split_line[0]
        model = split_line[1]
        result.append({
          "identifier": identifier,
          "model": model
        })

  with open('DeviceModels.json', 'w') as new_file:
    new_file.write(json.dumps(result))
  
  text_file.close()


if __name__ == "__main__":
    txt_to_json()


