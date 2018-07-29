FROM ruby:2.5
MAINTAINER Gonzalo Arreche <gonzaloarreche@gmail.com>

EXPOSE 3000
ENV RACK_ENV=production

RUN mkdir /app
WORKDIR /app

CMD ["bundle", "exec", "puma", "--preload", "-b", "tcp://0.0.0.0:3000"]

COPY Gemfile Gemfile.lock /app/
RUN bundle install --without development test

COPY . /app
