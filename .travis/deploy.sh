#!/usr/bin/env bash

# Requires the following environment variables:
# $ENVIRONMENT = The environment (production/release/staging).
# $CF_API = The URI of the Cloud Foundry instance.
# $CF_USERNAME = The Cloud Foundry username.
# $CF_PASSWORD = The Cloud Foundry password.
# $CF_ORGANISATION = The Cloud Foundry organisation.
# $CF_SPACE = The Cloud Foundry space.
# $CF_INSTANCES = The number of App instances required
# $CF_ROUTE = The public url of the app without the schema
# $CF_ENV_SERVICE = The name of the S3 bucket holding the .env files
# $CF_ENV_SERVICE_KEY = The name of the service key that holds the secret S3 bucket access details
# $CF_APP_NAME = The name of the main app as stated in the manifest

# Bail out on first error.
set -e

BLUE='\e[1;34m'
GREEN='\e[1;32m'
ENDCOLOUR='\e[1;m'

# Set environment variables.
echo -e "${BLUE}Setting deployment configuration for ${ENVIRONMENT}...${ENDCOLOUR}"
export ENV_SECRET_FILE=".env.admin.${ENVIRONMENT}"

# Connect to the Cloud Foundry API.
echo -e "${BLUE}Logging into Cloud Foundry...${ENDCOLOUR}"

# Login to Cloud Foundry.
cf login -a "$CF_API" -u "$CF_USERNAME" -p "$CF_PASSWORD" -o "$CF_ORGANISATION" -s "$CF_SPACE"

# Get the .env file from the secret S3 bucket
echo -e "${BLUE}Retreive the AWS S3 access credentials${ENDCOLOUR}"
cf service-key $CF_ENV_SERVICE $CF_ENV_SERVICE_KEY | sed -n '/{/,/}/p' | jq . > secret_access.json

# Export the AWS S3 access credentials for use by the AWS CLI
export AWS_ACCESS_KEY_ID=`jq -r .aws_access_key_id secret_access.json`
export AWS_DEFAULT_REGION=`jq -r .aws_region secret_access.json`
export AWS_SECRET_ACCESS_KEY=`jq -r .aws_secret_access_key secret_access.json`
export AWS_BUCKET_NAME=`jq -r .bucket_name secret_access.json`
export AWS_DEFAULT_OUTPUT=json

# Remove the secret file
rm secret_access.json

echo -e "${BLUE}Retrieve the relevant dotenv file${ENDCOLOUR}"
aws s3api get-object --bucket ${AWS_BUCKET_NAME} --key ${ENV_SECRET_FILE} ${PWD}/.env

# Declare the configuration variables for the deployment.
echo "Setting deployment configuration for ${ENVIRONMENT}..."
ENV_SECRET_ID=".env.admin.${ENVIRONMENT}"

# Build.
echo -e "${BLUE}Building...${ENDCOLOUR}"
node_modules/.bin/vue-cli-service build --mode ${ENVIRONMENT}

# Deploy.
echo -e "${GREEN}Deploy the prepared app${ENDCOLOUR}"

cf push --memory=64M --var instances=$CF_INSTANCES --var route=$CF_ROUTE

# Remove the AWS client
rm -Rf ${PWD}/aws
