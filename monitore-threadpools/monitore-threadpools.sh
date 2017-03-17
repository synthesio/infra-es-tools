#!/bin/bash
CURL_BIN=$(which curl)
ENDPOINT=${1}
THREADPOOL=search

if [ -z ${1} ]; then
  echo "Endpoint is missing, exiting"
  echo "Usage: ${0} some.host.tld [thread pool]"
  echo "Thread pool: bulk, index, percolate, search (default)"
  exit 1
fi

if [ -z ${CURL_BIN} ]; then 
  echo "Curl binary is missing, exiting" 
  exit 1 
fi

if [ ! -z ${2} ]; then
  THREADPOOL=${2}
fi

while true; do 
  clear
  ${CURL_BIN} -XGET "${ENDPOINT}:9200/_cat/thread_pool?v&h=host,${THREADPOOL}.queue,${THREADPOOL}.active,${THREADPOOL}.rejected,${THREADPOOL}.completed" 2>/dev/null | sort -unk 2,3 
  sleep 5 
done
