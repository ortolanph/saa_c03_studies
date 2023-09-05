import random
import time
import os

env_vars = {
    "BREACHING_THRESHOLD": 0.99,
    "BREACHING_POINTS_MAX": 20,
    "TOTAL_DURATION_MINUTES": 5,
    "THRESHOLD": 70,
    "NORMAL_MIN": 45,
    "NORMAL_MAX": 55,
    "BREACHING_MIN": 70,
    "BREACHING_MAX": 85,
}


def load_env_values():
    env_vars["BREACHING_THRESHOLD"] = float(os.getenv('BREACHING_THRESHOLD', env_vars["BREACHING_THRESHOLD"]))
    env_vars["BREACHING_POINTS_MAX"] = int(os.getenv('BREACHING_POINTS_MAX', env_vars["BREACHING_POINTS_MAX"]))
    env_vars["TOTAL_DURATION_MINUTES"] = int(os.getenv('TOTAL_DURATION_MINUTES', env_vars["TOTAL_DURATION_MINUTES"]))
    env_vars["THRESHOLD"] = int(os.getenv('THRESHOLD', env_vars["THRESHOLD"]))
    env_vars["NORMAL_MIN"] = int(os.getenv('NORMAL_MIN', env_vars["NORMAL_MIN"]))
    env_vars["NORMAL_MAX"] = int(os.getenv('NORMAL_MAX', env_vars["NORMAL_MAX"]))
    env_vars["BREACHING_MIN"] = int(os.getenv('BREACHING_MIN', env_vars["BREACHING_MIN"]))
    env_vars["BREACHING_MAX"] = int(os.getenv('BREACHING_MAX', env_vars["BREACHING_MAX"]))


def log_message(current_time, counter, current_value, threshold):
    if current_value < threshold:
        status = "UNDER_THRESHOLD"
    elif current_value == threshold:
        status = "ON_THRESHOLD"
    else:
        status = "OVER_THRESHOLD"

    print(f"{current_time}, {counter}, CPU Usage, {status}, {threshold}, {current_value}")


def generate_cpu_usage(minimum, maximum):
    return int(random.uniform(minimum, maximum))


def run_simulation():
    counter = 0
    breaching = False
    breaching_points = 0
    counter_snapshot = 0

    total_time = env_vars["TOTAL_DURATION_MINUTES"] * 60

    while counter <= total_time:
        current_timestamp = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime())

        if not breaching:
            test_breach = random.uniform(0, 1)

            if test_breach >= env_vars["BREACHING_THRESHOLD"]:
                counter_snapshot = counter
                breaching = True
                breaching_points = int(random.uniform(5, env_vars["BREACHING_POINTS_MAX"]))

        if breaching and counter <= (counter_snapshot + breaching_points):
            cpu_usage = generate_cpu_usage(env_vars["BREACHING_MIN"], env_vars["BREACHING_MAX"])
        else:
            cpu_usage = generate_cpu_usage(env_vars["NORMAL_MIN"], env_vars["NORMAL_MAX"])
            breaching = False

        log_message(current_timestamp, counter, cpu_usage, env_vars["THRESHOLD"])

        time.sleep(1)
        counter += 1


def lambda_handler(event, context):
    print("CPU Simulator Lambda")
    print("Created by Paulo Ortolan (paulo.ortolan@gmail.com)")
    print("You can copy, make it better, and make another")

    print("Context")
    print(event)

    print("Context")
    print(context)

    load_env_values()
    run_simulation()


if __name__ == '__main__':
    lambda_handler({}, {})
