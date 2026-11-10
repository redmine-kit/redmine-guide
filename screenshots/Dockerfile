# syntax=docker/dockerfile:1
# Redmine 7.0.3 for the guide's screenshots (bin/screenshots). Built from this
# directory: docker build -f screenshots/Dockerfile screenshots
FROM ruby:4.0@sha256:a69f361db050bb2c65ec66ef75411bfc4ce2e1d993ba1179fac4e4ba6ecfe91f
# Subversion for the repository screens (Redmine's test repository).
RUN apt-get update && apt-get install -y --no-install-recommends subversion && rm -rf /var/lib/apt/lists/*
ARG REDMINE_VERSION=7.0.3
ARG REDMINE_SHA256=0b6b24c033341a9d7ad52cfcfa7b1bc913c191c7a604f740d863f16249dd3c15
RUN curl -fsSLo /tmp/redmine.tar.gz "https://www.redmine.org/releases/redmine-${REDMINE_VERSION}.tar.gz" \
  && echo "${REDMINE_SHA256}  /tmp/redmine.tar.gz" | sha256sum -c - \
  && tar -xzf /tmp/redmine.tar.gz -C / && mv "/redmine-${REDMINE_VERSION}" /redmine \
  && rm /tmp/redmine.tar.gz
WORKDIR /redmine
COPY database.yml config/database.yml
RUN bundle config set --local without development \
  && bundle install --jobs 4
ENV RAILS_ENV=test
