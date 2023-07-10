FROM alpine:3.18

LABEL maintainer="Nate Wilken <wilken@asu.edu>"
LABEL repository="https://github.com/nwilken/tailpipe"

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 555 /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

USER nobody
