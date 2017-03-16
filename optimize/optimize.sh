#!/bin/sh
HOST=$1
CURL_BIN=$(which curl)

if [ -z "$HOST" ]; then
  echo "Host is missing" 
  exit 1 
fi 

if [ -z "$CURL_BIN" ]; then 
  echo "Curl binary is missing" 
  exit 1 
fi

for indice in $(${CURL_BIN} -XGET http://${HOST}:9200/_cat/indices | sort -rnk7 | awk '{print $3}'); do 
  if [ ! -z "$indice" ]; then 
    echo "Processing indice ${indice}" 
    ${CURL_BIN} -XPOST http://${HOST}:9200/${indice}/_optimize?max_num_segments=1 
    echo 
  fi 
done

exit 0
