FROM ruby:2.1.2

RUN gem install bundler

ADD . /app
WORKDIR /app
RUN bundle install

EXPOSE 4567
CMD rackup -p 4567 -o 0.0.0.0