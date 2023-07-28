#!/bin/bash


while read line; do
  if [[ ! $line =~ "#" ]] && [[ ! -z $line ]]; then
    PACKS="$PACKS$line "
  fi
done < list.list
CMD="sudo -S apt install -y $PACKS"
eval $CMD
