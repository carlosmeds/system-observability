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

    app.logger.setLevel(logging.DEBUG)

    log_request_middleware(app)

    if not any(isinstance(handler, LokiHandler) for handler in app.logger.handlers):
        app.logger.addHandler(loki_handler)

    class LoggingContextFilter(logging.Filter):
        def filter(self, record):
            span = get_current_span()
            if not span or not span.get_span_context().is_valid:
                tracer = get_tracer(__name__)
                with tracer.start_as_current_span("auto-generated-span"):
                    span = get_current_span()
            record.trace_id = format(span.get_span_context().trace_id, '032x')
            record.span_id = format(span.get_span_context().span_id, '016x')
            return True

    context_filter = LoggingContextFilter()
    app.logger.addFilter(context_filter)