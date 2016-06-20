#!/usr/bin/env bash

if (( $# == 0 ))
then
  exit 0
fi

if (( $# == 1 ))
then
  arr=($(echo "$1"))
  if (( ${#arr[@]} != 2 ))
  then
    exit 0
  fi
  config=${arr[0]}
  term=${arr[1]}
fi

if (( $# == 2 ))
then
  config=$1
  term=$2
fi

options=$(
  kubectl --kubeconfig="$HOME/.kube/$config" get pods | \
  grep '^[^ ]*' -o | \
  tail -n +2 | \
  grep $term
)

while read -r option; do
  echo "[$option]"
  echo "command=copy"
  echo "icon="
  echo "subtext=Copy $option"
done <<< "$options"
