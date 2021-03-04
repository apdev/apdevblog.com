FROM ubuntu:14.04

ENV LC_ALL C.UTF-8

# Get dependencies
RUN apt-get update && apt-get install -y \
  curl \
  emacs24-nox \
  git \
  # ruby \
  ruby-dev \
  make \
  wget && \
  apt-get clean

COPY Gemfile Gemfile.lock /octopress/

WORKDIR /octopress
EXPOSE 4000

RUN gem install bundler -v '~> 1.5.0' && bundle install