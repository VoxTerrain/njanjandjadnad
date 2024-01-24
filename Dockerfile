# Use the official Node.js image as the base image
FROM node:14-alpine

# Set the working directory
WORKDIR /usr/src/app

# Clone the Pterodactyl repository
RUN apk add --no-cache git \
    && git clone --branch release https://github.com/pterodactyl/panel.git .

# Install dependencies
RUN apk add --no-cache yarn \
    && yarn install --frozen-lockfile

# Copy the environment configuration file
COPY .env.example .env

# Set the application key
RUN php artisan key:generate --force

# Set the admin account information
RUN php artisan p:user:make \
    --email=ro@ro.com \
    --username=admin \
    --first-name=Admin \
    --last-name=User \
    --password=romaniaooo \
    --admin

# Expose ports 80 and 443
EXPOSE 80
EXPOSE 443

# Start the application
CMD ["yarn", "start"]
