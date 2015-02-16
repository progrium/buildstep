
all: build

build:
	docker build -t progrium/buildstep .

test: build-test run-test

build-test:
	docker build -t progrium/buildstep-test ./test

run-test:
	docker run -v /var/run/docker.sock:/run/docker.sock -ti progrium/buildstep-test
