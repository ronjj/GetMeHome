class IncorrectDateFormatException(Exception):
  "Date formatting incorrect. Format is MM-DD-YYYY"

class PastDateException(Exception):
  "Cannot search for past dates. Must search for current or future date"