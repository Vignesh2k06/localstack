import json
import copy
import logging
from datetime import datetime
from typing import Callable

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def privacy_remover(message_body):
    """This will mask privacy fields"""
    privacy_fields = [
        "firstName", "lastName", "phoneNumber", "emailId"
        ]

    duplicated_message = copy.deepcopy(message_body)

    for fields in privacy_fields:
        if fields in duplicated_message:
            duplicated_message[fields] = "XXXX"
        if "student_formatted_data" in duplicated_message and \
                fields in duplicated_message["student_formatted_data"]:
            duplicated_message["student_formatted_data"][fields] = "XXXX"

    return duplicated_message

def log_splunk(message, processing_stage, context, resource_path, client_ip, invocation_timestamp, response_timestamp, status_code, request_payload={}, privacy_flag=False):
    
    if privacy_flag and request_payload != {}:
        request_payload = privacy_remover(request_payload)

    log_dict = {
        "message_type": "INFO",
        "correlation_id": context.aws_request_id,
        "error": None,
        "message": message,
        "timestamp": datetime.now().strftime("%d/%m/%Y %H:%M:%S"),
        "resource_path": resource_path,
        "client_ip": client_ip,
        "function_name": context.function_name
    }
    if  processing_stage != '':
        log_dict.update({
            "processing_stage": processing_stage
        })
    if (invocation_timestamp and response_timestamp) != '':
        processing_time = (response_timestamp - invocation_timestamp).total_seconds() # In seconds
        log_dict.update({
            'invcation_timestamp': invocation_timestamp.strftime('%Y-%m-%d %H:%M:%S.%f'),#UTC time
            'response_timestamp': response_timestamp.strftime('%Y-%m-%d %H:%M:%S.%f'),#UTC time
            'processing_time':  round(processing_time, 5)
        })

    if status_code == 200:
        logger.info(json.dumps(log_dict))
    else:
        log_dict['message_type'] = 'ERROR'
        log_dict['error'] = message
        log_dict['status'] = status_code
        logger.error(json.dumps(log_dict))

get_time: Callable = lambda: datetime.now()
