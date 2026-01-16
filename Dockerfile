FROM ollama/ollama:0.14.2@sha256:44893537fcc6f100b70ceb7f5c9fd8f787ba58f9f8ce73bf4a48a5b05fd8c422

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
