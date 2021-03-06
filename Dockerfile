FROM ubuntu:14.04

ENV LC_ALL C.UTF-8

# Get dependencies
RUN apt-get update && apt-get install -y \
  curl \
  emacs24-nox \
  git \
  python \
  ruby-dev \
  make \
  wget && \
  apt-get clean

WORKDIR /octopress

COPY Gemfile Gemfile.lock /octopress/
RUN gem install bundler -v '~> 1.5.0' && bundle install

EXPOSE 4000
