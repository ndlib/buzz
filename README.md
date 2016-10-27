# Buzz README

## Dependencies
Requires ruby v2.3.1

## Installation Notes

```console
$ bundle install
```

Generate a config/settings.yml with the following keys:
```
<rails environment>
  wowza:
    host: <host>
    port: <port>
    application: <wowza app name>
    instance: <wowza instance>
    cache_source_prefix: amazons3
    cache_source: <s3 bucket name>
``` 

Generate a config/secrets.yml with the following keys:
```
<rails environment>
  secret_key_base: <secret key>
```

Generate a config/database.yml with the following keys:
```
<rails environment>
  adapter: postgresql
  encoding: utf8
  reconnect: true
  pool: 5
  username: <db user>
  password: <db pass>
  host:     <db host>
  database: <db name>
  port:     <db port>
```

Create the database
```console
$ bundle exec rake db:create && bundle exec rake db:schema:load
```

## Running
```console
$ bundle exec rails server
```
