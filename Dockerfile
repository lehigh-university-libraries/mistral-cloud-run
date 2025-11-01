FROM ollama/ollama:0.12.9@sha256:889ae74bdb4aa541044574d3e5e5dedde3c682c8b7918b6792aa031e7dfc8f06

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
