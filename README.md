# Web Fetcher

## Disclaimer
I've tested this solution on both a Windows and a Mac.
If you're running this on a Linux, the linux solution below should work just like it worked for a Mac, but please let me know if there are any problems

## How to run

### Makefile

You can use the commands I defined in `Makefile` for simpler execution of the script and tests.
To run the app, simply run:
```
make run-linux-app ARGS="https://www.google.com https://autify.com" # linux
make run-win-app ARGS="https://www.google.com https://autify.com" # windows
```

To run the tests:
```
make run-tests
```

### Docker Commands

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
