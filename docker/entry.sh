echo Mapping SSM path "$ENV_SSM_PATH" to my environment.
service nginx start
exec bundle exec puma -b "unix://${APP_HOME}/shared/sockets/puma.sock"