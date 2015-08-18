#!/bin/bash
echo [$@]
echo "command=xdg-open \"https://lonelyplanet.atlassian.net/wiki/dosearchsite.action?queryString=$@\""
echo "icon="
echo "subtext=Search the Wiki for $@"
