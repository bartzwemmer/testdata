FROM apache/superset:6.0.0-py312

USER root
COPY requirements.txt /app/docker/requirements-local.txt
RUN /app/.venv/bin/python -m ensurepip && \
    /app/.venv/bin/python -m pip install --no-cache-dir -r /app/docker/requirements-local.txt

USER superset