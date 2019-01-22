# Running in development
To run this locally, from the root directory:
```bash
docker build . -f docker/Dockerfile -t buzz
docker run -p 80:80 --env PORT=80 \
  --env AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
  --env AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
  --env AWS_SECURITY_TOKEN=$AWS_SECURITY_TOKEN \
  --env AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN \
  --env AWS_REGION=$AWS_REGION \
  --env RAILS_LOG_TO_STDOUT=true \
  -it buzz
```

Note: The if you change the PORT env, you will need to match the port in the -p option above

## Running Integration Tests
```bash
newman run spec/postman/spec.json -e spec/postman/local_env.json
```

# Running in production
In production, the application's expected environment key/value pairs will be retrieved from SSM at the given ENV_SSM_PATH, while the AWS environment keys will be taken care of by ECS. Below is a simulated example of how this will be run when deployed as an ECS Task.
```bash
docker run -p 80:80 --env PORT=80 \
  --env AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
  --env AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
  --env AWS_SECURITY_TOKEN=$AWS_SECURITY_TOKEN \
  --env AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN \
  --env AWS_REGION=$AWS_REGION \
  --env ENV_SSM_PATH=all/buzz/production \
  --env RAILS_LOG_TO_STDOUT=true \
  -it buzz
```
