#!/bin/bash
if [ -n "$( echo "$*" | aspell list )" ]
then
  found=$(echo "$*" | aspell -a | sed "s/@(#) International Ispell Version 3.1.20 (but really Aspell 0.60.7-20110707)//g" | cut -d : -f 2 | sed 's/,/\n/g')
  for word in $found; do
    echo "[$word]"
    echo "command=copy"
    echo "icon=/home/bfalk/.config/Mutate/scripts/spell/spell_check.png"
    echo "subtext=suggest"
  done
else
  echo "[$*]"
  echo "command=copy"
  echo "icon=/home/bfalk/.config/Mutate/scripts/spell/spell_check.png"
  echo "subtext=correct"
fi
