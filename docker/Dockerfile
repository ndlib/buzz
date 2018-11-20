FROM ruby:2.4.4

RUN apt-get update -qq && apt-get install -y build-essential
RUN apt-get install -y nginx systemd

# Install chamber to get secrets from parameter store
RUN curl https://github.com/segmentio/chamber/releases/download/v2.2.0/chamber_v2.2.0_amd64.deb --output chamber.deb -L
RUN dpkg -i chamber.deb
# We are just using the account's default ssm key to encrypt the values
# If this changes, we'll need to override this alias
ENV CHAMBER_KMS_KEY_ALIAS=aws/ssm
ARG DEFAULT_ENV_SSM_PATH="all/buzz/prep"
ENV ENV_SSM_PATH=$DEFAULT_ENV_SSM_PATH

#ENV APP_HOME /app_root
# Continue to build in home/app 
ENV APP_HOME /home/app/buzz
RUN mkdir /home/app
RUN mkdir $APP_HOME
RUN mkdir -p $APP_HOME/shared/pids
RUN mkdir -p $APP_HOME/shared/sockets
RUN mkdir -p $APP_HOME/shared/log
WORKDIR $APP_HOME

RUN gem install bundler
COPY Gemfile* $APP_HOME/
ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
  BUNDLE_JOBS=4 \
  BUNDLE_PATH=/bundle
RUN bundle install --without test development

# Generate a self signed cert that can be used when iterating on this container locally
# In production, this will not be used since we are terminating at the load balancer
RUN openssl req -nodes -x509 -new -keyout self_signed.key -out self_signed.cert \
  -subj "/C=US/ST=IN/O=University of Notre Dame/OU=LIBITS"

# Update NGINX - Add local config file; remove default file from install
ADD docker/buzz.conf /etc/nginx/conf.d/buzz.conf
RUN rm /etc/nginx/sites-enabled/default

ADD docker/buzz-puma /etc/init.d
#ADD docker/puma.service /lib/systemd/system

COPY . $APP_HOME
WORKDIR $APP_HOME

ENV RAILS_ENV=pre_production
ARG DEFAULT_PORT="80"
ENV PORT=$DEFAULT_PORT
EXPOSE $PORT

# Routing will be handled via AWS infrastructure, and there are no static assets in this service.
# It's a rails based API, so we are probably ok to just use puma here and not add nginx.
# By default, this will not run under SSL, since we are terminating at the load balancer.
#CMD chamber exec $ENV_SSM_PATH -- bundle exec puma
WORKDIR $APP_HOME
CMD chamber exec $ENV_SSM_PATH -- /usr/local/bundle/bin/bundle exec puma -e $RAILS_ENV -C $APP_HOME/config/puma.rb $APP_HOME/config.ru
CMD chamber exec $ENV_SSM_PATH -- service nginx start
