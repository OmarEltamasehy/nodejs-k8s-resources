# Use Node.js v14 as the base image
FROM node:14

# Set the working directory to /app
WORKDIR /app

# Copy your application code to the container
COPY . /app

# Install any necessary dependencies for your application
RUN npm install

# Set the command to run your application
CMD ["node", "index.js"]
