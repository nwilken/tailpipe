FROM alpine:3.10
LABEL maintainer="Nate Wilken <wilken@asu.edu>"

RUN set -x && \
    apk --no-cache upgrade libssl1.1 libcrypto1.1 && \
    apk --no-cache add bash

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 555 /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

USER nobody
