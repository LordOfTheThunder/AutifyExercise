# Use the official Ruby image as the base
FROM ruby:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the Ruby script to the container
COPY . /app/

# Define the entry point command to run the Ruby script
CMD ["ruby", "fetch_web_pages.rb"]
