import json
import requests
from common.LambdaException import LambdaException


def do_get(client_url, headers, params={}):  # pylint: disable=C0116,W0102
    try:
        request_response = requests.get(
            url=client_url, headers=headers, params=params, timeout=15)
        status_code = request_response.status_code
        response = {}
        if status_code != 200:
            response.update({'status': status_code})
            return response

        response = request_response.json()
        response.update({'status': status_code})
        return response

    except Exception as err:
        raise LambdaException(err) from err


def do_post(client_url, headers, body):
    try:
        request_response = requests.post(
            url=client_url, headers=headers, data=json.dumps(body), timeout=15)
        response = {}
        status_code = request_response.status_code
        if status_code != 200:
            response.update({'status': status_code})
            return response
        response['data'] = request_response.json()
        response['status'] = status_code
        return response

    except Exception as err:
        raise LambdaException(err) from err
