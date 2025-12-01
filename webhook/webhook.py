import subprocess
from flask import Flask, request

app = Flask(__name__)

@app.route("/hook", methods=["POST"])
def hook():
    print("[Webhook] Received webhook")

    # Здесь можно проверить secret или branch
    # Например:
    # payload = request.json
    # print(payload)

    try:
        print("[Webhook] Running update.sh...")
        subprocess.check_call(["/bin/bash", "/app/update.sh"])
        print("[Webhook] Script finished.")
        return "OK", 200
    except subprocess.CalledProcessError as e:
        print(f"[Webhook] ERROR: {e}")
        return "ERROR", 500

@app.route("/")
def root():
    return "Webhook receiver is running"

if __name__ == "__main__":
    print("[Webhook] Starting Flask server...")
    app.run(host="0.0.0.0", port=19321)
