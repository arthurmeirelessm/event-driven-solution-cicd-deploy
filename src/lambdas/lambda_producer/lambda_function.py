import json
import os


def lambda_handler(event, context):
    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Request to API completed",
            "response_status": "",
            "api_url": "Versao 37"
        }),
    }
