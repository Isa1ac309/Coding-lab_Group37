import time
import random
import os
import sys
import signal

PID_FILE = "/tmp/hospital_system.pid"

ACTIVE_DIR = "active_logs"

def ensure_dirs():
    os.makedirs(ACTIVE_DIR, exist_ok=True)

def write_log(file_path, line):
    with open(file_path, "a") as f:
        f.write(line + "\n")

def generate_data():
    heart_rate = random.randint(60, 140)
    temp = round(random.uniform(35, 40), 1)
    water = random.randint(100, 500)

    hr_status = "CRITICAL" if heart_rate > 120 else "NORMAL"
    temp_status = "CRITICAL" if temp > 38 else "NORMAL"

    write_log(f"{ACTIVE_DIR}/heart_rate.log",
              f"{time.strftime('%Y-%m-%d %H:%M:%S')},DEVICE_HR,{heart_rate},{hr_status}")

    write_log(f"{ACTIVE_DIR}/temperature.log",
              f"{time.strftime('%Y-%m-%d %H:%M:%S')},DEVICE_TEMP,{temp},{temp_status}")

    write_log(f"{ACTIVE_DIR}/water_usage.log",
              f"ICU_WATER_RESERVE,DEVICE_WATER,{water}")

def start_engine():
    ensure_dirs()

    with open(PID_FILE, "w") as f:
        f.write(str(os.getpid()))

    print("KNH Hospital System STARTED...")

    try:
        while True:
            generate_data()
            time.sleep(2)
    except KeyboardInterrupt:
        stop_engine()

def stop_engine():
    if os.path.exists(PID_FILE):
        os.remove(PID_FILE)
    print("KNH Hospital System STOPPED")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 hospital_system.py start|stop")
        sys.exit(1)

    if sys.argv[1] == "start":
        start_engine()
    elif sys.argv[1] == "stop":
        stop_engine()
