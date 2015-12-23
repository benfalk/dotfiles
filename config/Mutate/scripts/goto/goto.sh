#!/bin/sh
wmctrl -l | grep -i $* | sed "s/.*$(hostname) //g" | sed "s/'/\\\'/" | sort | xargs -n 1 -I LINE \
  echo -e "[LINE]\ncommand=wmctrl -a LINE\nicon=\nsubtext="
