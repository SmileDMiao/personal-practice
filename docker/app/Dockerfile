FROM ruby:2.6
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
ENV RAILS_ROOT /var/www/personal_practice
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT
ARG RAILS_ENV
ENV RAILS_ENV=$RAILS_ENV
ENV RAKE_ENV=$RAILS_ENV
ENV RACK_ENV=$RAILS_ENV

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN if [[ "$RAILS_ENV" == "production" ]]; then\
bundle install --jobs 20 --retry 5 --without development test;\
else bundle install --jobs 20 --retry 5; fi

COPY . .

RUN bundle exec rake assets:precompile
EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
