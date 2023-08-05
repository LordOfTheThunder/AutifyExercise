# Web Fetcher

## How to run
The commands below will explain how to run the app using Docker native commands based on platform.
You can also use the `Makefile` for simpler execution of the script and tests.
To run the app, simply run:
```
make build-app
make run https://www.google.com https://autify.com
```

To run the tests:
```
make build-tests
make run-tests
```

To build the docker image, run:
```
docker build -t web_page_fetcher .
```

Depending on your OS, please run docker the following ways to get the fetched HTTP files to a persisted volume.

### Windows Command Line
```
docker run -v %cd%:/app/saved_web_pages web_page_fetcher ruby fetch_web_pages.rb https://www.google.com https://autify.com
```

### Linux/Mac
```
docker run -v "$(pwd)":/app/saved_web_pages web_page_fetcher ruby fetch_web_pages.rb https://www.google.com https://autify.com
```
