#!/usr/bin/env bash
set -e

[ -n "$STDOUT_PIPE" ] && ! [ -p "$STDOUT_PIPE" ] && mkfifo -m 666 "$STDOUT_PIPE"

exec "$@"
