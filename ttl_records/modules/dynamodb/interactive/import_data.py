import csv
import random
import time

import boto3

stamped_data = []


def get_table():
    session = (boto3.Session(profile_name='saa_c03_studies'))
    resource = session.resource("dynamodb")
    table = resource.Table("ttl-records-books-database")

    return table


def insert_item(stamped_item, table):
    response = table.put_item(Item=stamped_item)

    print(response)


def import_data():
    table = get_table()

    with (open('library.csv') as csvfile):
        reader = csv.DictReader(csvfile)

        for row in reader:
            current_time = int(time.time())
            random_time = random.randint(15, 120)
            row["ExpiredAt"] = current_time + (random_time * 60)
            row["Id"] = int(row["Id"])
            stamped_data.append(row)

    for stamped in stamped_data:
        print(stamped.keys())
        insert_item(stamped, table)


if __name__ == '__main__':
    import_data()
