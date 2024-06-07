FROM docker.io/searxng/searxng:latest

COPY logo.png /usr/local/searxng/searx/static/themes/simple/img/searxng.png
RUN chmod 444 /usr/local/searxng/searx/static/themes/simple/img/searxng.png

COPY settings.yml /etc/searxng/settings.yml
COPY limiter.toml /etc/searxng/limiter.toml
