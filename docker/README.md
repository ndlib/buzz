# Running in Docker

This project includes a docker-compose configuration for testing how this project will be run in ECS.

```bash
docker-compose up
docker-compose exec rails bundle exec rake db:schema:load
```

## Running Integration Tests

```bash
newman run spec/postman/spec.json -e spec/postman/local_env.json
```
