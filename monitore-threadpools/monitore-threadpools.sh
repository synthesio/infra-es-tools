#!/bin/bash

if [ -z $1 ]; then
  echo "Usage: ${0} endpoint [queue]"
  echo "Thread pool: bulk, index, percolate, search (default)"
  exit 1
else
  endpoint=${1}
fi

if [ -z $2 ]; then
  queue=search
else
  queue=${2}
fi

while true; do 
  clear
  curl -XGET "${endpoint}:9200/_cat/thread_pool?v&h=host,${queue}.queue,${queue}.active,${queue}.rejected,${queue}.completed" 2>/dev/null | sort -unk 2,3 
  sleep 5 
done
