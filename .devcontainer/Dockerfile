# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.3.0
FROM ghcr.io/rails/devcontainer/images/ruby:$RUBY_VERSION

RUN sudo apt-get update && \
    sudo apt-get install -y \
    libpq-dev \
    postgresql-client \
    iputils-ping
