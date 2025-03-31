import time

class CircuitBreaker:
    def __init__(self, threshold=3, recovery_time=10):
        self.failure_counts = {}
        self.open_circuits = {}
        self.threshold = threshold
        self.recovery_time = recovery_time

    def record_failure(self, service_name):
        self.failure_counts[service_name] = self.failure_counts.get(service_name, 0) + 1
        if self.failure_counts[service_name] >= self.threshold:
            self.open_circuits[service_name] = time.time()

    def is_open(self, service_name):
        if service_name not in self.open_circuits:
            return False
        open_time = self.open_circuits[service_name]
        if time.time() - open_time > self.recovery_time:
            # Attempt to close the circuit
            del self.open_circuits[service_name]
            self.failure_counts[service_name] = 0
            return False
        return True

    def reset(self, service_name):
        self.failure_counts[service_name] = 0
        self.open_circuits.pop(service_name, None)
