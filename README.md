# localstack

python -m venv venv



Steps

docker pull localstack/localstack
docker run --rm -it -p 4566:4566 -p 4571:4571 localstack/localstack

pip install awscli-local



referance

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/guides/custom-service-endpoints




problems to be addressed
1. WAF
2. API Gateway Logs
3. VPC



commands to list:
awslocal s3api list-buckets
awslocal lambda list-functions  
awslocal apigateway get-rest-apis
awslocal s3 ls s3://localstack-test-bucket-v1 