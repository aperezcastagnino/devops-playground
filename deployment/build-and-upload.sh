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

if [[ "$IMAGE_TYPE" != "api" && "$IMAGE_TYPE" != "client" ]]; then
    echo "Err: You must enter 'api' or 'client'"
    exit 1
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

DOCKERFILE_PATH="../${IMAGE_TYPE}"

echo "Building the Docker Image: $IMAGE_TYPE..."
docker build -t $IMAGE_NAME -f ${DOCKERFILE_PATH}/Dockerfile ${DOCKERFILE_PATH}

echo "Tagging the Docker Image..."
docker tag $IMAGE_NAME:$TAG $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPOSITORY_NAME:$TAG

echo "Uploading the Docker Image..."
docker push $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPOSITORY_NAME:$TAG

echo "Upload completed for $IMAGE_TYPE."
