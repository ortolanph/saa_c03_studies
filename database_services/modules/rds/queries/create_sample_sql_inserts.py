import sys
import json

import requests

BASE_URL = "https://randomuser.me/api/"
DEFAULT_TOTAL_RESULTS = 100

class Person:
    _id = 0
    _last_name = ""
    _first_name = ""
    _gender = ""
    _address = ""
    _city = ""
    _department = ""
    _country = ""
    _postal_code = ""
    _phone = ""
    _mobile_phone = ""
    _dob = ""
    _age = ""
    _email = ""

    def __init__(self, id, name, gender, location, phone, mobile_phone, dob, email):
        self._id = id
        self.parse_name(name)
        self._gender = gender
        self.parse_location(location)
        self._phone = phone
        self._mobile_phone = mobile_phone
        self.parse_dob(dob)
        self._email = email
        pass

    def parse_name(self, name):
        self._last_name = name["last"]
        self._first_name = name["first"]

    def parse_location(self, location):
        self._city = location["city"].replace("'", "''")
        self._department = location["state"].replace("'", "''")
        self._country = location["country"].replace("'", "''")
        self._postal_code = str(location["postcode"])
        self._address = f'{location["street"]["number"]} {location["street"]["name"].strip()}'.replace("'", "''")

    def parse_dob(self, dob_data):
        self._dob = dob_data["date"][0:len(dob_data["date"]) - 5:].replace("T", " ")
        self._age = dob_data["age"]

    def to_sql_insert(self):
        return f"insert into people (id, last_name, first_name, gender, address, city, department, country, postal_code, phone, mobile_phone, dob, age, email) " \
               f"values ({self._id}, '{self._last_name}', '{self._first_name}', '{self._gender}', '{self._address}', '{self._city}', '{self._department}', '{self._department}', '{self._country}', '{self._postal_code}', '{self._mobile_phone}', '{self._dob}', '{self._age}', '{self._email}');"


def get_user_data(results_to_fetch):
    user_data = requests.get(
        BASE_URL,
        {
            "nat": "au,br,ca,ch,de,dk,es,fi,fr,gb,ie,mx,us",
            "results": results_to_fetch
        }
    )

    return user_data.text

if __name__ == '__main__':
    arguments = sys.argv[1:]
    total_results = DEFAULT_TOTAL_RESULTS

    if arguments:
        total_results = int(arguments[0])

    data = json.loads(get_user_data(total_results))

    people = []
    id = 0

    for result in data["results"]:
        id += 1
        person = Person(id, result["name"], result["gender"], result["location"], result["phone"], result["cell"], result["dob"], result["email"])
        print(person.to_sql_insert())
