from flask import Flask, jsonify
import requests
import logging
import os
from dotenv import load_dotenv
load_dotenv()

app = Flask(__name__)
logging.basicConfig(level=logging.INFO)

KOMODO_URL = os.getenv("KOMODO_URL")
API_KEY = os.getenv("API_KEY")
API_SECRET = os.getenv("API_SECRET")

HEADERS = {
    "Content-Type": "application/json",
    "X-Api-Key": API_KEY,
    "X-Api-Secret": API_SECRET
}

@app.route("/")
def container_update_summary():
    try:
        # Get all containers
        containers_resp = requests.post(KOMODO_URL, headers=HEADERS, json={
            "type": "ListDockerContainers",
            "params": { "server": os.getenv("KOMODO_SERVER") }
        })
        containers_resp.raise_for_status()  # Raise exception for non-200 responses
        containers = containers_resp.json()

        # Get updates
        updates_resp = requests.post(KOMODO_URL, headers=HEADERS, json={
            "type": "ListUpdates",
            "params": {}
        })
        updates_resp.raise_for_status()
        updates = updates_resp.json()

        # Extract image names
        update_images = {u["image"] for u in updates if "image" in u}

        # Count matches
        total = len(containers)
        updatable = sum(1 for c in containers if c.get("image") in update_images)

        return jsonify({
            "total": total,
            "updates": updatable
        })

    except requests.exceptions.RequestException as e:
        logging.error(f"API request failed: {str(e)}")
        return jsonify({"error": "Failed to communicate with Komodo API", "details": str(e)}), 500
    except Exception as e:
        logging.error(f"Unexpected error: {str(e)}")
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5070)
