# Set base image.
FROM node:lts-fermium

# Set maintainer to Ayup Digital.
LABEL maintainer="Ayup Digital"

# Install git for faster package downloads.
RUN apt-get install -y git

# Expose port 8080 for HTTP access.
EXPOSE 8080

# Set the working directory to the project root.
WORKDIR /var/www/html
