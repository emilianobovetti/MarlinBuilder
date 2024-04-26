FROM debian:12-slim

ENV DEBIAN_FRONTEND=noninteractive \
  DEBCONF_NOWARNINGS=yes \
  LANG=C.UTF-8 \
  APP_UID=1000 \
  APP_GID=1000

RUN set -xe \
  && groupadd --gid "$APP_GID" app \
  && useradd --create-home --home-dir /home/app --uid "$APP_UID" --gid "$APP_GID" app \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    python3.11 \
    python3.11-venv \
  && rm -rf /var/lib/apt/lists/*

USER app

ARG MARLIN_VERSION
ARG MARLIN_SHA256

ARG PLATFORMIO_CORE_VERSION
ARG PLATFORMIO_CORE_SHA256

RUN set -xe \
  && PLATFORMIO_DOWNLOAD_URL="https://raw.githubusercontent.com/platformio/platformio-core-installer/v$PLATFORMIO_CORE_VERSION/get-platformio.py" \
  && curl -fsSL -o /tmp/get-platformio.py "$PLATFORMIO_DOWNLOAD_URL" \
  && echo "$PLATFORMIO_CORE_SHA256  /tmp/get-platformio.py" | sha256sum -c - \
  && python3 /tmp/get-platformio.py \
  && MARLIN_DOWNLOAD_URL="https://github.com/MarlinFirmware/Marlin/archive/$MARLIN_VERSION.tar.gz" \
  && curl -fsSL -o /tmp/marlin.tar.gz "$MARLIN_DOWNLOAD_URL" \
  && echo "$MARLIN_SHA256  /tmp/marlin.tar.gz" | sha256sum -c - \
  && mkdir -p /home/app/marlin \
  && tar -xzC /home/app/marlin --strip-components=1 -f /tmp/marlin.tar.gz

USER root

RUN set -xe \
  && for name in pio platformio; do \
      ln -s /home/app/.platformio/penv/bin/$name /usr/local/bin/$name; \
    done \
  && ls -A1 /tmp | xargs rm -rf

USER app

WORKDIR /home/app/marlin
