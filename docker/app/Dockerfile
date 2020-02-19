# Base Image: ruby2.6
FROM ruby:2.6

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Root Path
ENV RAILS_ROOT /var/www/personal_practice

# Make a new directory where our project will be copied
RUN mkdir -p $RAILS_ROOT

# Set working directory within container
WORKDIR $RAILS_ROOT

# Setting env up
ARG RAILS_ENV
ENV RAILS_ENV=$RAILS_ENV
ENV RAKE_ENV=$RAILS_ENV
ENV RACK_ENV=$RAILS_ENV

# Adding gems
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

# Development/Production differs in bundle install
RUN bundle install

# Adding project files
COPY . .

# Precompile
RUN bundle exec rake assets:precompile

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]