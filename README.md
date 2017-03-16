# Elasticsearch tools

A set of scripts to manage our Elasticsearch clusters

## Monitore threadpools

A script to monitore threadpools on a cluster.

```
./monitore-threadpools/monitore-threadpools.sh endpoint [thread pool]
```

Thread pools can be:

* bulk
* index
* percolate
* search (default)

## Optimize 

A script to optimize an Elasticsearch cluster, processing the indexes with the most deleted documents first

```
./optimize/optimize.sh endpoint
```
