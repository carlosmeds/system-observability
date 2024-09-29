import logging
from logging_loki import LokiHandler
from opentelemetry.trace import get_current_span, get_tracer
from setup.logging_utils import log_request_middleware

def configure_logging(app):
    loki_handler = LokiHandler(
        url="http://loki:3100/loki/api/v1/push",
        tags={"application": "flask-app"},
        version="1",
    )

    formatter = logging.Formatter('%(name)s - %(levelname)s - %(message)s - trace_id=%(trace_id)s - span_id=%(span_id)s')
    loki_handler.setFormatter(formatter)

    app.logger.setLevel(logging.INFO)

    log_request_middleware(app)

    if not any(isinstance(handler, LokiHandler) for handler in app.logger.handlers):
        app.logger.addHandler(loki_handler)

