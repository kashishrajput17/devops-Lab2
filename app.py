import os
import platform
import socket
from flask import Flask, jsonify

app = Flask(__name__)


@app.route("/")
def home():
    return "Hello from a containerized Flask app!\n"


@app.route("/health")
def health():
    return jsonify(status="ok")


@app.route("/api/info")
def info():
    return jsonify(
        hostname=socket.gethostname(),
        python=platform.python_version(),
        environment=os.environ.get("APP_ENV", "development"),
        pid=os.getpid(),
    )


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
