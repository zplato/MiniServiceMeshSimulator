# mesh_router.py
import requests
from flask import Flask, request
from itertools import cycle

app = Flask(__name__)
services = cycle(["http://localhost:5001", "http://localhost:5002", "http://localhost:5003"])
global_timeout = 1

@app.route("/route")
def route_request():
    target = next(services)
    timeout = global_timeout
    try:
        res = requests.get(target, timeout=timeout)
        return res.text, res.status_code
    except Exception as e:
        return f"Error routing to {target}: {str(e)}", 500

if __name__ == "__main__":
    app.run(port=8000)
