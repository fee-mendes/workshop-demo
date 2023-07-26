#!/bin/bash

echo "Creating schema on target cluster"
cqlsh -f schema.cql cluster2-node1

# Let's give it a few seconds before firing up the replicator job
# to avoid potential races.
sleep 10

echo "Starting to replicate data from cluster1 to cluster2"
./examples/replicator/replicator -destination cluster2-node1 -source cluster1-node1 -table devices -keyspace iot
