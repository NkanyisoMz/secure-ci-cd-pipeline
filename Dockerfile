# Slim base image = reduced attack surface
FROM python:3.12-slim

# Security: no .pyc files, unbuffered logs
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install minimal system deps
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy dependency file first (better caching)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY app/ .

# Create non-root user
RUN useradd -m appuser
USER appuser

# Expose Flask port
EXPOSE 5000

# Start app
CMD ["python", "app.py"]