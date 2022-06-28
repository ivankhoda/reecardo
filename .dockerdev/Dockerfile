ARG RUBY_VERSION=3.1.0
FROM ruby:$RUBY_VERSION-slim-buster

ARG PG_VERSION=13

ARG BUNDLER_VERSION=2.3.16

ENV APP_USER=ivan \
    LANG=C.UTF-8 
ENV GEM_HOME=/home/$APP_USER/gems
ENV APP_HOME=/home/$APP_USER/app
ENV PATH=$PATH:$GEM_HOME/bin
RUN useradd -ms /bin/bash $APP_USER

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
COPY Gemfile ./Gemfile
COPY Gemfile.lock ./Gemfile.lock
RUN bundle install
USER $APP_USER
# Add a script to be executed every time the container starts.
COPY . usr/bin/
RUN chmod +x usr/bin/build.sh
ENTRYPOINT ["build.sh"]
EXPOSE 4000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]


WORKDIR /home/$APP_USER/app
