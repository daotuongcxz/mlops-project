# ========== Stage 1: Builder ==========
FROM python:3.11 as builder

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir -e .

COPY long-state-452316-d2-1e09a3e52402.json /tmp/credentials.json
ENV GOOGLE_APPLICATION_CREDENTIALS=/tmp/credentials.json

RUN PYTHONPATH=/app python pipeline/training_pipeline.py

# ========== Stage 2: Runtime ==========
FROM python:3.11-slim

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=builder /app/ /app/

RUN apt-get update && apt-get install -y --no-install-recommends \
    libgomp1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    FLASK_APP=application.py

EXPOSE 5000
CMD ["python", "application.py"]