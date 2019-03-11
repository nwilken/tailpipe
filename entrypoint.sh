#!/usr/bin/env bash
set -e

for i in $@; do
  [ -n "$i" ] && ! [ -p "$i" ] && mkfifo -m 666 "$i"
  (cat < "$i" 3> "$i" &)
done

while true; do sleep 86400; done
