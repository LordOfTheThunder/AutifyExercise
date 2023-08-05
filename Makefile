TEST_IMAGE_NAME = web_page_fetcher_test
TEST_CONTAINER_NAME = test_container
APP_IMAGE_NAME = web_page_fetcher_app
APP_CONTAINER_NAME = app_container

DIR := ${CURDIR}

build-test:
	docker build -t $(TEST_IMAGE_NAME) -f Dockerfile.test .

test: build-test
	docker run --name $(TEST_CONTAINER_NAME) $(TEST_IMAGE_NAME) || true

clean-test:
	docker rm $(TEST_CONTAINER_NAME)

build-app:
	docker build -t $(APP_IMAGE_NAME) .

run-app: build-app
	docker run --name $(APP_CONTAINER_NAME) -v ${DIR}:/app/saved_web_pages web_page_fetcher_app ruby fetch_web_pages.rb --metadata $(filter-out $@,$(MAKECMDGOALS))

clean-app:
	docker rm $(APP_CONTAINER_NAME)

run-tests: test clean-test

run: run-app clean-app
