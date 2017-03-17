#!/bin/bash
CURL_BIN=$(which curl)
ENDPOINT=${1}

if [ -z ${ENDPOINT} ]; then
  echo "Endpoint is missing, exiting"
  echo "Usage: ${0} some.host.tld"
  exit 1 
fi 

if [ -z ${CURL_BIN} ]; then 
  echo "Curl binary is missing, exiting" 
  exit 1 
fi

for indice in $(${CURL_BIN} -XGET http://${ENDPOINT}:9200/_cat/indices | sort -rnk7 | awk '{print $3}'); do 
  if [ ! -z "$indice" ]; then 
    echo "Processing indice ${indice}" 
    ${CURL_BIN} -XPOST http://${ENDPOINT}:9200/${indice}/_optimize?max_num_segments=1 
    echo 
  fi 
done

exit 0
