FROM ruby:2.4.4

RUN apt-get update -qq && apt-get install -y build-essential
RUN apt-get install -y nginx

# Continue to build in home/app
ENV APP_HOME /home/app/buzz
RUN mkdir -p $APP_HOME
RUN mkdir -p $APP_HOME/shared/pids
RUN mkdir -p $APP_HOME/shared/sockets
RUN mkdir -p $APP_HOME/shared/log

RUN gem install bundler
COPY Gemfile* $APP_HOME/
ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
  BUNDLE_JOBS=4 \
  BUNDLE_PATH=/bundle
RUN bundle install --without test development

# Update NGINX - Add local config file; remove default file from install
ADD docker/nginx.conf /etc/nginx/conf.d/my_app.conf
RUN rm /etc/nginx/sites-enabled/default

COPY . $APP_HOME
WORKDIR $APP_HOME

COPY docker/database.yml $APP_HOME/config/database.yml

RUN chmod u+x docker/start_services.sh
# ENTRYPOINT ["bash", "docker/entry.sh"]
# By default, start the required services
CMD docker/start_services.sh
