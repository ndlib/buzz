FROM ruby:2.3.1

COPY . /project_root

WORKDIR /project_root
RUN bundle install

CMD bundle exec rake db:create && bundle exec rake db:schema:load && bundle exec rails server
