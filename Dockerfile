FROM ollama/ollama:0.18.2@sha256:5a5d014aa774f78ebe1340c0d4afc2e35afc12a2c3b34c84e71f78ea20af4ba3

ENV \
  OLLAMA_HOST=0.0.0.0:8080 \
  OLLAMA_MODELS=/models \
  OLLAMA_DEBUG=false \
  OLLAMA_KEEP_ALIVE=-1 \
  OLLAMA_MODEL=mistral-small3.2:24b

RUN ollama serve & sleep 5 && ollama pull $OLLAMA_MODEL

WORKDIR /app

COPY docker-entrypoint.sh .

ENTRYPOINT ["/app/docker-entrypoint.sh"]
