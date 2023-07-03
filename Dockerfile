FROM debian:buster-slim
RUN apt-get update \
    apt-get install curl, wget, nodejs, npm
ADD App/* .

