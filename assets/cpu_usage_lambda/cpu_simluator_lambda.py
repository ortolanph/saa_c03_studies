import random
import time
import os

env_vars = {
    "BREACHING_CHANCE": 0.99,
    "BREACHING_POINTS_MAX": 20,
    "TOTAL_DURATION_MINUTES": 10,
    "THRESHOLD": 70,
    "NORMAL_MIN": 45,
    "NORMAL_MAX": 55,
    "BREACHING_MIN": 70,
    "BREACHING_MAX": 85,
}


def load_env_values():
    env_vars["BREACHING_CHANCE"] = float(os.getenv('BREACHING_CHANCE', env_vars["BREACHING_CHANCE"]))
    env_vars["BREACHING_POINTS_MAX"] = int(os.getenv('BREACHING_POINTS_MAX', env_vars["BREACHING_POINTS_MAX"]))
    env_vars["TOTAL_DURATION_MINUTES"] = int(os.getenv('TOTAL_DURATION_MINUTES', env_vars["TOTAL_DURATION_MINUTES"]))
    env_vars["THRESHOLD"] = int(os.getenv('THRESHOLD', env_vars["THRESHOLD"]))
    env_vars["NORMAL_MIN"] = int(os.getenv('NORMAL_MIN', env_vars["NORMAL_MIN"]))
    env_vars["NORMAL_MAX"] = int(os.getenv('NORMAL_MAX', env_vars["NORMAL_MAX"]))
    env_vars["BREACHING_MIN"] = int(os.getenv('BREACHING_MIN', env_vars["BREACHING_MIN"]))
    env_vars["BREACHING_MIN"] = int(os.getenv('BREACHING_MAX', env_vars["BREACHING_MIN"]))


def lambda_handler(event, context):
    load_env_values()


if __name__ == '__main__':
    lambda_handler(None, None)



def main():
    timestamps = []
    numeric_values = []

    counter = 0
    breaching = False
    breaching_points = 0
    counter_snapshot = 0

    while counter <= TOTAL_DURATION:
        current_timestamp = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime())

        if not breaching:
            test_breach = random.uniform(0, 1)

            if test_breach >= BREACHING_CHANCE:
                counter_snapshot = counter
                breaching = True
                breaching_points = int(random.uniform(5, BREACHING_POINTS_MAX))

        if breaching and counter <= (counter_snapshot + breaching_points):
            cpu_usage = generate_cpu_usage(BREACHING_MIN, BREACHING_MAX)
        else:
            cpu_usage = generate_cpu_usage(NORMAL_MIN, NORMAL_MAX)
            breaching = False

        timestamps.append(current_timestamp)
        numeric_values.append(cpu_usage)

        print(generate_message(current_timestamp, counter, cpu_usage, THRESHOLD))

        time.sleep(1)
        counter += 1


def generate_cpu_usage(minimum, maximum):
    return int(random.uniform(minimum, maximum))


def generate_message(current_time, counter, current_value, threshold):
    if current_value < threshold:
        status = "UNDER_THRESHOLD"
    elif current_value == threshold:
        status = "ON_THRESHOLD"
    else:
        status = "OVER_THRESHOLD"

    return f"{current_time}, {counter}, CPU Usage, {status}, {threshold}, {current_value}"
