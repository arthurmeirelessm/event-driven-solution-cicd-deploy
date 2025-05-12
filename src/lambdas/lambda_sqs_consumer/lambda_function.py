import json
import os

def lambda_handler(event, context):
    queue_url = os.environ.get("QUEUE_URL", "not-set")
    messages = []

    for record in event.get("Records", []):
        body = record.get("body")
        messages.append(body)

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": f"Processed {len(messages)} messages",
            "queue_url": queue_url,
            "messages": messages
        }),
    }
