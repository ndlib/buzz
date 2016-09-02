# Buzz README

## Dependencies
Requires ruby v2.3.1

## Installation Notes

```console
$ bundle install
```

Generate a secrets file or use the example
```console
$ cp config/secrets.example.yml config/secrets.yml
```

Generate a database.yml or use the example
```console
$ cp config/database_example.yml config/database.yml
```

Create the database
```console
$ bundle exec rake db:create && bundle exec rake db:schema:load
```

## Running
```console
$ bundle exec rails server
```
