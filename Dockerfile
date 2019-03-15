FROM ruby:2.6-alpine3.8

MAINTAINER kozakana

RUN apk update && \
    apk add pdftk ghostscript && \
    mkdir /pdf

WORKDIR /

COPY grayscale.rb /

CMD ["ruby", "/grayscale.rb", "-s", "c:1", "-s", "g:2-r2", "-s", "c:r1"]
