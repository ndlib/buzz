FROM ruby:2.4.4

RUN apt-get update -qq && apt-get install -y build-essential
RUN apt-get install -y nginx

# Install chamber to get secrets from parameter store
RUN curl https://github.com/segmentio/chamber/releases/download/v2.2.0/chamber_v2.2.0_amd64.deb --output chamber.deb -L
RUN dpkg -i chamber.deb
# We are just using the account's default ssm key to encrypt the values
# If this changes, we'll need to override this alias
ENV CHAMBER_KMS_KEY_ALIAS=aws/ssm
ARG DEFAULT_ENV_SSM_PATH="all/buzz/prep"
ENV ENV_SSM_PATH=$DEFAULT_ENV_SSM_PATH

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

ENV RAILS_ENV=pre_production

# Routing will be handled via AWS infrastructure, and there are no static assets in this service.
# It's a rails based API, so we are probably ok to just use puma here and not add nginx.
# By default, this will not run under SSL, since we are terminating at the load balancer.
RUN chmod u+x docker/entry.sh
CMD chamber exec $ENV_SSM_PATH -- sh docker/entry.sh
