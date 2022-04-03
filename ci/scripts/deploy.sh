#!/bin/bash
set -euo pipefail

npm run build

# Out out of AWS data collection
export SAM_CLI_TELEMETRY=0

#Configuration
export AWS_REGION="ap-southeast-2"
export serverName="valhiem-test8"
export discordWebHook="https://discord.com/api/webhooks/948765948964397066/7IEWojGl2pCGZDnh2_vo_uqjq_bHcNI_-ROD-RVrr0aHunzGyicyOo6pJgR5uWjh2es-"

###
deploymentBucketName="${serverName}-deploy-bucket"

echo "# [Deploy] S3 Bucket"
{
  aws cloudformation deploy \
    --capabilities CAPABILITY_IAM \
    --template-file ./infrastructure/deployment-bucket.yml \
    --stack-name ${deploymentBucketName} \
    --no-fail-on-empty-changeset \
    --parameter-overrides DeploymentBucketName=${deploymentBucketName}
} || {
  echo "## Error deploying S3 Bucket template"
  exit -1
}

echo ""
echo "# [Deploy] AWS SAM Services"
{
  sam deploy \
    --region ${AWS_REGION} \
    --capabilities CAPABILITY_IAM CAPABILITY_AUTO_EXPAND \
    --template-file ./infrastructure/.aws-sam/build/template.yaml \
    --stack-name ${serverName} \
    --s3-bucket ${deploymentBucketName} \
    --no-fail-on-empty-changeset \
    --parameter-overrides ServerName=${serverName} DiscordWebHook=${discordWebHook}
} || {
  echo "## Error deploying SAM template"
  exit -1


}


