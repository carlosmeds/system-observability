from flask import request

def log_request_middleware(app):
    @app.before_request
    def log_request():
        if request.path == "/metrics":
            return
        app.logger.info(
            f"Input: Method: {request.method}, Path: {request.path}, "
            f"IP: {request.remote_addr}"
        )

    @app.after_request
    def log_response(response):
        if request.path == "/metrics" or response.status_code >= 400:
            return response
        app.logger.info(
            f"Output: Method: {request.method}, Path: {request.path}, "
            f"IP: {request.remote_addr}, Status: {response.status_code}"
        )
        app.logger.debug(f"Response: {response.data}")
        return response