FROM ruby:2.6-alpine3.8

RUN apk update && \
    apk add pdftk && \
    mkdir /input_pdf && \
    mkdir /output_pdf

WORKDIR /

COPY grayscale.rb /

CMD ["ruby", "/grayscale.rb"]
