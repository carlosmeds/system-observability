from flask import Flask, jsonify
import os
import logging
from random import randint
from prometheus_flask_exporter import PrometheusMetrics
from logging_loki import LokiHandler
from logging_utils import log_request_middleware

app = Flask(__name__)
metrics = PrometheusMetrics(app)

loki_handler = LokiHandler(
    url="http://loki:3100/loki/api/v1/push",
    tags={"application": "flask-app"},
    version="1",
)

formatter = logging.Formatter('%(name)s - %(levelname)s - %(message)s')
loki_handler.setFormatter(formatter)

app.logger.setLevel(logging.INFO)
log_request_middleware(app)

if not any(isinstance(handler, LokiHandler) for handler in app.logger.handlers):
    app.logger.addHandler(loki_handler)

@app.route('/', methods=['GET'])
def roll_dice():
    app.logger.info("[ROUTE] - called /")
    dice_value = randint(1, 6)
    return jsonify({'dice_value': dice_value})

@app.route("/fail")
def fail():
    app.logger.info("[ROUTE] - called /failed")
    1/0
    return 'fail'

@app.errorhandler(500)
def handle_500(error):
    app.logger.error(f"Server error: {error}")
    return str(error), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(os.getenv('PORT', 5000)))
