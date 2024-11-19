

# Use a more recent Python version
FROM python:3.6

# Set working directory
WORKDIR /app

# Copy requirements.txt first to leverage caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files
COPY . .

# Set environment variables
ENV YOUR_NAME="friend"
ENV TZ=UTC

# Expose the Flask app port
EXPOSE 5500

# Use CMD instead of ENTRYPOINT for flexibility
CMD ["python", "app.py"]
