import csv
import random
import time
from datetime import datetime, timedelta

import boto3

stamped_data = []


def get_table():
    session = (boto3.Session(profile_name='saa_c03_studies', region_name="eu-west-1"))
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
            random_minutes = random.randint(15, 120)
            current_time = datetime.now()
            expires_at = current_time + timedelta(minutes=random_minutes)

            row["ExpiresAt"] = int(time.mktime(expires_at.timetuple()))
            row["Id"] = int(row["Id"])

            print(f"-------------------------------------------------------")
            print(f"Inserting book {row['Title']}")
            print(f"-------------------------------------------------------")
            print(f"Current Time at {str(current_time)}")
            print(f"Expires at {str(expires_at)}")
            stamped_data.append(row)
            print(f"-------------------------------------------------------")

    for stamped in stamped_data:
        print(stamped.keys())
        insert_item(stamped, table)


if __name__ == '__main__':
    import_data()
