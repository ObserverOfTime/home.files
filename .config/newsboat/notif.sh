#!/bin/sh

exec notify-send -u normal -t 2000 \
  -i feed-subscribe 'RSS' "$@"
