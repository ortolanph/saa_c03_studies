import os


class EnvironmentData:
    breaching_chance = 0.99
    breaching_max_points = 20
    total_duration = 10
    # TOTAL_DURATION = 10 * 60
    threshold = 70
    normal_min = 45
    normal_max = 55
    breaching_min = 70
    breaching_max = 85

    def __init__(self, breaching_chance, breaching_max_points, total_duration, total_duration_minutes, threshold, ):
        pass


def lambda_handler(event, context):
    print(os.getenv('HOME_KEY_NOT_EXISTS', '/home/work/python'))


if __name__ == '__main__':
    lambda_handler(None, None)

import random
import time

import matplotlib.pyplot as plt

BREACHING_CHANCE = 0.99
BREACHING_POINTS_MAX = 20

TOTAL_DURATION = 10 * 60

THRESHOLD = 70

NORMAL_MIN = 45
NORMAL_MAX = 55

BREACHING_MIN = 70
BREACHING_MAX = 85


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

    plot_graph(timestamps, numeric_values)


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


def plot_graph(timestamps, numeric_values):
    plt.figure(figsize=(20, 12))
    plt.plot(timestamps, numeric_values, marker='o')
    plt.axhline(y=70, color='r', linestyle='--', label='Threshold (70)')
    plt.xlabel('Iteration')
    plt.ylabel('CPU Usage')
    plt.title('CPU Usage over Iteration')
    plt.legend()
    plt.xticks(rotation=45)
    plt.tight_layout()
    plt.show()

# if __name__ == "__main__":
#     peak_counter = 0
#     start_time = time.time()
#     main()
