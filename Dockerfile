FROM ubuntu:bionic

RUN groupadd -g 1001 user
RUN useradd -u 1001 -g 1001 -G video -ms /bin/bash user


RUN apt-get -y update \
  && apt-get -y upgrade \
  && apt-get install -y \
    gimp --no-install-recommends

RUN rm -rf /var/lib/apt/lists/*

USER user
ENTRYPOINT ["gimp"]
