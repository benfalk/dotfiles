#!/bin/bash
echo [$@]
echo "command=xdg-open \"https://github.com/search?q=$@\""
echo "icon="
echo "subtext=Search on github for $@"
