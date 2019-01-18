# tailpipe

docker-compose.yml example:

```
version: "3.2"
  
services:
  app:
    image: alpine:latest
    volumes:
      - logs-volume:/app/log
    command: ["sh","-c","! [ -p /app/log/access.log ] && mkfifo -m 666 /app/log/access.log; ! [ -p /app/log/error.log ] && mkfifo -m 666 /app/log/error.log; while true; do echo \"$$(date)\" > /app/log/access.log; sleep 2; echo \"$$(date)\" > /app/log/error.log; sleep 1; echo \"app\"; sleep 7; done"]

  access_log:
    image: asuuto/tailpipe:latest
    read_only: true
    volumes:
      - logs-volume:/tmp/log
    restart: always
    command: /tmp/log/access.log

  error_log:
    image: asuuto/tailpipe:latest
    read_only: true
    volumes:
      - logs-volume:/tmp/log
    restart: always
    command: /tmp/log/error.log

volumes:
  logs-volume:
```
