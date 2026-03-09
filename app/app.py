from flask import Flask, jsonify
import requests

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({"message": "Secure CI/CD Demo"})

@app.route("/health")
def health():
    return jsonify({"status": "ok"})

@app.route("/external")
def external():
    r = requests.get("https://api.github.com")
    return jsonify({"github_status": r.status_code})

if __name__ == "__main__":
    app.run(debug=False)