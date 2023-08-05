FROM ruby:latest

WORKDIR /app

COPY . /app/

CMD ["ruby", "fetch_web_pages.rb"]
