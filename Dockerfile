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

RUN mkdir -p /xteve
RUN wget https://github.com/xteve-project/xTeVe-Downloads/raw/master/xteve_linux_amd64.zip -O temp.zip; unzip temp.zip -d /xteve; rm temp.zip

VOLUME /home/xteve/.xteve

EXPOSE ${XTEVE_PORT}

HEALTHCHECK --interval=30s --start-period=30s --retries=3 --timeout=10s \
  CMD curl -f http://localhost:${XTEVE_PORT}/ || exit 1


ENTRYPOINT /xteve/xteve
CMD ["-port=${XTEVE_PORT}"]
