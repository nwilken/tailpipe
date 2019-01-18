FROM alpine:3.8
MAINTAINER Nate Wilken <wilken@asu.edu>

RUN apk update && apk add bash

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["sh", "-c", "tail -F \"${STDOUT_PIPE}\""]
