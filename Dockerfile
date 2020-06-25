FROM ruby:2.7-alpine3.12

MAINTAINER kozakana

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.8/main" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.8/community" >> /etc/apk/repositories && \
    apk update && \
    apk add pdftk ghostscript && \
    mkdir /pdf

WORKDIR /

COPY grayscale.rb /

CMD ["ruby", "/grayscale.rb", "-s", "c:1", "-s", "g:2-r2", "-s", "c:r1"]
