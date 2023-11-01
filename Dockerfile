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

ENV PLATFORMIO_VERSION="1.2.1" \
  MARLIN_VERSION="2.1.2.1"

RUN set -xe \
  && PLATFORMIO_DOWNLOAD_URL="https://raw.githubusercontent.com/platformio/platformio-core-installer/v$PLATFORMIO_VERSION/get-platformio.py" \
  && PLATFORMIO_DOWNLOAD_SHA256="85670d0df6e1c16393236bf6bd5bd712a6e293c2af612840921d8a102c0d3830" \
  && curl -fsSL -o /tmp/get-platformio.py "$PLATFORMIO_DOWNLOAD_URL" \
  && echo "$PLATFORMIO_DOWNLOAD_SHA256  /tmp/get-platformio.py" | sha256sum -c - \
  && python3 /tmp/get-platformio.py \
  && MARLIN_DOWNLOAD_URL="https://github.com/MarlinFirmware/Marlin/archive/$MARLIN_VERSION.tar.gz" \
  && MARLIN_DOWNLOAD_SHA256="31ba7e56def2ddec17dc1983c74dc567d5f0220ad3f211d00714196c082b7807" \
  && curl -fsSL -o /tmp/marlin.tar.gz "$MARLIN_DOWNLOAD_URL" \
  && echo "$MARLIN_DOWNLOAD_SHA256  /tmp/marlin.tar.gz" | sha256sum -c - \
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
