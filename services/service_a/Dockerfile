FROM python:3.10-slim

# Set the working directory upon boot
WORKDIR /app

# Copy and install the requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source code
COPY . .

CMD ["python", "service_a.py"]
