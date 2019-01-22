# Runs nginx + puma services
service nginx start
bundle exec puma -b "unix://${APP_HOME}/shared/sockets/puma.sock"
