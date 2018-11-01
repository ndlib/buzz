# Running in development
To run this locally, from the root directory:
```bash
docker build . -f docker/Dockerfile -t buzz
docker run -p 443:443 --env PORT=443 \
  --env AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
  --env AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
  --env AWS_SECURITY_TOKEN=$AWS_SECURITY_TOKEN \
  --env AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN \
  --env AWS_REGION=$AWS_REGION \
  --env-file ./docker/dev_env \
  -it buzz sh ./docker/ssl_cmd.sh
```

Note: The if you change the PORT env, you will need to match the port in the -p option above

An example curl test with expected output:
```bash
$ curl --insecure https://localhost/token
{"redirect":"https://localhost/login"}
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
  -it buzz
```
