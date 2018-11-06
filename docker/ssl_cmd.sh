echo Mapping SSM path "$ENV_SSM_PATH" to my environment.
exec chamber exec "$ENV_SSM_PATH" -- bundle exec puma -b "ssl://0.0.0.0:$PORT?key=self_signed.key&cert=self_signed.cert"
