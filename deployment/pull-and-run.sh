#!/bin/bash

AWS_REGION="us-east-2"
ACCOUNT_ID="721133465773"
TAG="latest"
PROFILE="xl-devops"

IMAGE_NAME_BACKEND="ahora_si_final_final-client"
IMAGE_NAME_FRONTEND="ahora_si_final_final-api"
REPOSITORY_NAME_BACKEND="pei-training-api"
REPOSITORY_NAME_FRONTEND="pei-training-client"

IMAGE_TYPE=$1
PORTS=$2

if [[ "$IMAGE_TYPE" != "api" && "$IMAGE_TYPE" != "client" ]]; then
    echo "Err: You must enter 'api' or 'client'"
    exit 1
fi

if [ -z "$PORTS" ]; then
    PORTS=80
fi

if [[ "$IMAGE_TYPE" == "api" ]]; then
  IMAGE_NAME=$IMAGE_NAME_BACKEND
  REPOSITORY_NAME=$REPOSITORY_NAME_BACKEND
fi

if [[ "$IMAGE_TYPE" == "client" ]]; then
  IMAGE_NAME=$REPOSITORY_NAME_BACKEND
  REPOSITORY_NAME=$REPOSITORY_NAME_FRONTEND
fi

echo "Logging into AWS ECR..."
AWS_PROFILE=${PROFILE} aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

IMAGE_URI="$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPOSITORY_NAME:$TAG"

echo "Pulling Docker image: $IMAGE_URI..."
docker pull $IMAGE_URI

if docker ps -a --format '{{.Names}}' | grep -Eq "^$REPOSITORY_NAME\$"; then
    echo "Stopping and removing existing container: $REPOSITORY_NAME..."
    docker stop $REPOSITORY_NAME
    docker rm $REPOSITORY_NAME
fi

echo "Running container: $REPOSITORY_NAME..."
docker run -d --name $REPOSITORY_NAME -p $PORTS:$PORTS $IMAGE_URI

echo "Deployment complete!"
