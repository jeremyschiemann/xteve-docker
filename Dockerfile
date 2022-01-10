# Taken from https://github.com/alturismo/xteve/blob/master/Dockerfile
# adjusted to own needs

FROM alpine:latest
RUN apk update
RUN apk upgrade
RUN apk add --no-cache ca-certificates

MAINTAINER jeremyschiemann jeremy.schiemann@gmail.com

RUN apk add --no-cache curl

# Timezone (TZ)
RUN apk update && apk add --no-cache tzdata
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apk add --no-cache bash

VOLUME /config
VOLUME /root/.xteve
VOLUME /tmp/xteve

RUN wget https://github.com/xteve-project/xTeVe-Downloads/raw/master/xteve_linux_amd64.zip -O temp.zip; unzip temp.zip -d /usr/bin/; rm temp.zip

EXPOSE ${XTEVE_PORT}
