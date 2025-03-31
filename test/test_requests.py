# test/test_requests.py
import requests

success, fail = 0, 0
for _ in range(100):
    r = requests.get("http://localhost:8000/route")
    if r.status_code == 200:
        success += 1
    else:
        fail += 1

print(f"Success: {success}, Fail: {fail}")