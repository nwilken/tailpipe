# tailpipe

Tailpipe is intended for containerized workloads and Kubernetes pods where continuously growing log files filling up disk space/ephemeral storage is undesirable.

The container converts each named file passed as an argument to a pipe and starts a background process that opens the pipe(s) for both reading and writing. Each write is read and redirected to a file descriptor (console output) before the data is truncated, effectively keeping disk utilization for each file-turned-pipe at 0 bytes.

## Examples:

### Kubernetes (as Deployment):

```
apiVersion: deployment/v1
kind: Deployment
metadata:
  name: example-deployment
spec:
  template:
    spec:
      volumes:
        - name: logs-volume
          emptyDir: {}
          sizeLimit: 10Mi
      containers:
        - name: example-application
          image: alpine:latest
        - name: access-log
          image: asuuto/tailpipe:latest
          volumeMounts:
            - name: logs-volume
              mountPath: /temp/logs
          args: ["/temp/logs/error.log"]
        - name: error-log
          image: asuuto/tailpipe:latest
          volumeMounts:
            - name: logs-volume
              mountPath: /temp/logs
          args: ["/temp/logs/error.log"]
```

### docker-compose.yml:

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
