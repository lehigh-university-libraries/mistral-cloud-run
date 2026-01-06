FROM ollama/ollama:0.13.5@sha256:2c9595c555fd70a28363489ac03bd5bf9e7c5bdf2890373c3a830ffd7252ce6d

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
