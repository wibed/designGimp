# Design Environment, exposing a local directory
# and storing the home folder for configuration persistence
# dont forget to enable X11 access: xhost +local:

.PHONY: help purge sync run

help:	Makefile
	sed -n '1,3p' $<

.DEFAULT_GOAL := run
TAGNAME=gimp
SCRIPTPATH="$(shell cd "$(shell dirname "$0")" ; pwd -P)"

purge:
	docker container rm $(shell docker ps --all | grep gimp | cut -d' ' -f1) || true
	docker volume rm ${TAGNAME}Data || true
	docker volume create ${TAGNAME}Data
	docker build . --no-cache -t ${TAGNAME}

sync:
	docker build . -t ${TAGNAME}

run:
	docker run \
		-itd \
		-e DISPLAY="${DISPLAY}" \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v ${TAGNAME}Data:/home/user \
		-v ${SCRIPTPATH}/Pictures:/home/user/Pictures \
		${TAGNAME}
