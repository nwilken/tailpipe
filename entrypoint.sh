#!/usr/bin/env bash
set -e

for i in $@; do
  [ -n "$i" ] && ! [ -p "$i" ] && mkfifo -m 666 "$i"
done

tail -F "$@"
