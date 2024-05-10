# Use the official Ubuntu image as a base
FROM ubuntu:latest

# Update package lists and install necessary packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    php \
    php-cli \
    php-fpm \
    nginx \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Clone your code from GitHub
RUN git clone https://github.com/remozaza/Sk .

# Install Python dependencies
RUN pip3 install -r requirements.txt --break-system-packages

# Copy Nginx configuration file
COPY nginx/default.conf /etc/nginx/sites-available/default

# Expose ports for PHP-FPM (9000) and Nginx (80)
EXPOSE 9000
EXPOSE 80

# Start PHP-FPM and Nginx when the container starts
CMD service php7.4-fpm start && nginx -g 'daemon off;'
