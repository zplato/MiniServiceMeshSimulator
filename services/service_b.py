# services/service_a.py
from flask import Flask
import random
import time

app = Flask(__name__)

@app.route("/")
def handle():

    delay = 2 # seconds

    # Simulate delay
    if random.random() < 0.3:
        time.sleep(delay)

    if random.random() < 0.2:
        return "Service B failed", 500


    return "Hello from Service B", 200 # Healthy response

if __name__ == "__main__":
    app.run(port=5002)