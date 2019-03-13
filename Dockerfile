FROM ruby:2.6-alpine3.8

MAINTAINER kozakana

RUN apk update && \
    apk add pdftk ghostscript && \
    mkdir /pdf

WORKDIR /

COPY grayscale.rb /

CMD ["ruby", "/grayscale.rb"]
