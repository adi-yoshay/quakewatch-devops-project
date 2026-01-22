# Use a lightweight Python base image
FROM python:3.10-slim

# Set the working directory inside the container
WORKDIR /app

# Copy all project files into the container
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Create logs directory (the app writes logs here)
RUN mkdir -p logs

# Expose Flask default port
EXPOSE 5000

# Start the application
CMD ["python", "app.py"]

