TEST_IMAGE_NAME = web_page_fetcher_test
TEST_CONTAINER_NAME = test_container
APP_IMAGE_NAME = web_page_fetcher_app
APP_CONTAINER_NAME = app_container

WINDOWS_DIR := ${CURDIR}
LINUX_DIR = "$(pwd)"

build-test:
	docker build -t $(TEST_IMAGE_NAME) -f Dockerfile.test .

test: build-test
	docker run --name $(TEST_CONTAINER_NAME) $(TEST_IMAGE_NAME) || true

clean-test:
	docker rm $(TEST_CONTAINER_NAME)

build-app:
	docker build -t $(APP_IMAGE_NAME) .

win-app: build-app
	docker run --name $(APP_CONTAINER_NAME) -v ${WINDOWS_DIR}:/app/saved_web_pages web_page_fetcher_app ruby fetch_web_pages.rb --metadata $(ARGS)

linux-app: build-app
	docker run --name $(APP_CONTAINER_NAME) -v ${LINUX_DIR}:/app/saved_web_pages web_page_fetcher_app ruby fetch_web_pages.rb --metadata $(ARGS)

clean-app:
	docker rm $(APP_CONTAINER_NAME)

run-tests: test clean-test

run-win-app: win-app clean-app

run-linux-app: linux-app clean-app
