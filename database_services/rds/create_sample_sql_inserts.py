import json

import requests

BASE_URL = "https://randomuser.me/api/"

class Person:
    _id = 0
    _last_name = ""
    _first_name = ""
    _address = ""
    _phone = ""

    def __init__(self, id, name, location, phone):
        self._id = id
        self.parse_name(name)
        self.parse_location(location)
        self._phone = phone
        pass

    def parse_name(self, name):
        self._last_name = name["last"]
        self._first_name = name["first"]

    def parse_location(self, location):
        local_address = f'{location["street"]["number"]} {location["street"]["name"].strip()}'
        departamental_address = f'{location["city"]}, {location["state"]}, {location["country"]}, Post Code {location["postcode"]}'
        self._address = f"{local_address}, {departamental_address}"

    def to_sql_insert(self):
        return f"insert into people (id, last_name, first_name, address, phone) values ({self._id}, '{self._last_name}', '{self._first_name}', '{self._address}', '{self._phone}');"


def get_user_data():
    user_data = requests.get(
        BASE_URL,
        {
            "nat": "au,br,ca,ch,de,dk,es,fi,fr,gb,ie,mx,us",
            "results": 100
        }
    )

    return user_data.text

if __name__ == '__main__':
    data = json.loads(get_user_data())

    people = []
    id = 0

    for result in data["results"]:
        id += 1
        person = Person(id, result["name"], result["location"], result["phone"])
        print(person.to_sql_insert())