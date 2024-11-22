import os

STAGE = os.getenv('STAGE')

BP_PORTAL_MS_PATH = f'/{STAGE}/v1'

# Counsellor portal path
BP_PORTAL_FILE_LOGS_PATH = '/sales-reconciliation/logs'
BP_PORTAL_DOWNLOAD_LOG_FILE_PATH = '/sales-reconciliation/file-download'

APPLICATION_JSON = 'application/json'

PRESIGNED_URL_EXPIRY_SECONDS = 120
MAX_ALLOWED_DOCUMENT_SIZE_IN_BYTES = "2000000"

QUARANTINE_BUCKET_REGION = "ap-southeast-1"
QUARANTINE_BUCKET_NAME = f"{STAGE}-ses-business-process-portal-quarantine-bucket"
