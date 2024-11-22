# from os import environ
# from botocore.config import Config

# import boto3

# from common.ParameterStoreHelper import ParameterStoreHelper
# from common.Constants import QUARANTINE_BUCKET_REGION

# ssm = ParameterStoreHelper()

# ssm_list = [
#     environ['QUARANTINE_ACCOUNT_ID'],
#     environ['QUARANTINE_KMS_KEY_ID']
# ]
# ssm_value_list = ssm.get_list_from_ssm_parameters_store(ssm_list, True)

# quarantine_account_id = ssm_value_list[environ['QUARANTINE_ACCOUNT_ID']]
# quarantine_kms_key_id = ssm_value_list[environ['QUARANTINE_KMS_KEY_ID']]

# my_config = Config(
#     region_name = QUARANTINE_BUCKET_REGION,
#     signature_version = 's3v4',
#     retries = {
#         'max_attempts': 5,
#         'mode': 'standard'
#     }
# )

# s3_client = boto3.client('s3', config=my_config)
