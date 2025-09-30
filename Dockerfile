FROM ollama/ollama:0.12.3@sha256:c622a7adec67cf5bd7fe1802b7e26aa583a955a54e91d132889301f50c3e0bd0

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
