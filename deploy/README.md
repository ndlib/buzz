# Deployment

## Requirements
Before you begin, you must have an existing VPC with two private and two public subnets. These stacks must be run in order of:
  1. app-infrastructure.yml
  1. service.yml for test
  1. service.yml for prod
  1. service-pipeline.yml

## Application infrastructure stack
```console
aws cloudformation deploy \
  --capabilities CAPABILITY_IAM \
  --template-file deploy/app-infrastructure.yml \
  --stack-name buzz-app-infrastructure \
  --parameter-overrides NameTag='testlibnd-buzzappinfrastructure-prod' \
    ContactTag='me@myhost.com' OwnerTag='me' \
    VPCID=my-vpc-id
```

## Application service (test)
```console
aws cloudformation deploy \
  --capabilities CAPABILITY_IAM \
  --stack-name buzz-service-test \
  --template-file deploy/service.yml \
  --parameter-overrides NameTag='testlibnd-buzzservice-test' ContactTag='me@myhost.com' OwnerTag='my-id' \
    VPCID=my-vpc-id PrivateSubnet1ID=my-subnet-id PrivateSubnet2ID=my-subnet-id \
    PublicSubnet1ID=my-subnet-id PublicSubnet2ID=my-subnet-id DesiredCount=1 \
    AppEnvPath='all/buzz/prep'
```

## Application service (prod)
```console
aws cloudformation deploy \
  --capabilities CAPABILITY_IAM \
  --stack-name buzz-service-prod \
  --template-file deploy/service.yml \
  --parameter-overrides NameTag='testlibnd-buzzservice-prod' ContactTag='me@myhost.com' OwnerTag='my-id' \
    VPCID=my-vpc-id PrivateSubnet1ID=my-subnet-id PrivateSubnet2ID=my-subnet-id \
    PublicSubnet1ID=my-subnet-id PublicSubnet2ID=my-subnet-id DesiredCount=1 \
    AppEnvPath='all/buzz/production'
```

## Service Pipeline
This pipeline will deploy to test, then to production, so it expects two different service stacks to exist. In this example, it uses stack names of "buzz-service-test" and "buzz-service-prod".

```console
aws cloudformation deploy \
  --capabilities CAPABILITY_IAM \
  --stack-name buzz-service-pipeline \
  --template-file deploy/service-pipeline.yml \
  --parameter-overrides OAuth=my-github-oauth Approvers="me@myhost.com" \
    ProdServiceStackName=buzz-service-prod TestServiceStackName=buzz-service-test InfrastructureStackName=buzz-app-infrastructure \
    NameTag='libnd-buzzservicepipeline-prod' ContactTag='me@myhost.com' OwnerTag='my-id' \
    CDBranchName='master' TestUrl='hostname-of-target-to-test'
```
## Service Pipeline monitoring and notification
This pipeline is for monitoring and notification of the buzz-service-pipeline".

```console
aws cloudformation deploy \
  --capabilities CAPABILITY_IAM \
  --stack-name buzz-service-pipeline-monitoring \
  --template-file deploy/service-pipeline-monitoring.yml \
  --parameter-overrides PipelineStackName=buzz-service-pipeline Receivers="mylist@myhost.com" 
```

## Rotating parameters in the AppEnvPath
If the values of the parameters stored in the AppEnvPath have changed, you don't need to deploy a new task revision. You can perform a forced redeployment of the existing task definition for the service. Ex:
```console
aws ecs update-service --force-new-deployment \
  --service buzz-service-test \
  --cluster buzz-app-infrastructure-ContainerCluster-ID
```
