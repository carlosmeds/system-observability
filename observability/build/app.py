from flask import Flask, jsonify
import os
from random import randint

from setup.metrics import configure_metrics
from setup.logging import configure_logging
from setup.telemetry import configure_tracing

app = Flask(__name__)

configure_metrics(app)
configure_tracing(app)
configure_logging(app)

@app.route('/', methods=['GET'])
def roll_dice():
    app.logger.info("[ROUTE] - called /")
    dice_value = randint(1, 6)
    return jsonify({'dice_value': dice_value})

@app.route("/fail")
def fail():
    app.logger.info("[ROUTE] - called /fail")
    1/0
    return 'fail'

@app.errorhandler(500)
def handle_500(error):
    app.logger.error(f"Server error: {error}")
    return str(error), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(os.getenv('PORT', 5000)))
