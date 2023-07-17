#!/bin/bash

while true; do
  if [ -d ./.venv ]; then
    echo $(pwd)
    break
  elif [ $(pwd) == $HOME ]; then
   # echo "nakatta yo"
    break
  else
    cd ..
  fi
done
