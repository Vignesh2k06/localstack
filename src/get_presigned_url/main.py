"""
  @Python program
  @File name    : main.py
  @Lambda name  : {ENV}-ses-bp-portal-bff-get-presigned-url
  @Since        : 10-05-2024
  @Author       : Vignesh Boopathy
  @Version      : 1.0
  @Description  : Lambda Function is a used to get post persigned URL.
"""


import json

def handler(event, context):

    # Parse the input event
    print("event ===", event)

    event_query_param = event.get('queryStringParameters', {})
    name = event_query_param.get("name", "test")

    # Create a response
    response = {
        'statusCode': 200,
        'body': f'Hello, {name}! Welcome to AWS Lambda.'
    }

    # Log some information
    print(f"Request processed for name: {name}")
    print(f"Remaining time: {context.get_remaining_time_in_millis()} ms")

    print("res ===", response)

    return response
