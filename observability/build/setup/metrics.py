from prometheus_flask_exporter import PrometheusMetrics

def configure_metrics(app):
    metrics = PrometheusMetrics(app)