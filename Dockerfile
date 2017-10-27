FROM ruby:2.4.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /fast-poll
WORKDIR /fast-poll
ADD Gemfile /fast-poll/Gemfile
ADD Gemfile.lock /fast-poll/Gemfile.lock
RUN bundle install
ADD . /fast-poll