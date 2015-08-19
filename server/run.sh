#!/usr/bin/env bash
/entrypoint.sh couchbase-server &

sleep 15

buckets=$(/opt/couchbase/bin/couchbase-cli bucket-list \
-c 127.0.0.1 \
-u Administrator -p password)

if [ -z "$buckets" ]
	then
		/opt/couchbase/bin/couchbase-cli cluster-init \
		-c 127.0.0.1 \
		--cluster-init-username=Administrator \
		--cluster-init-password=password \
		--cluster-init-ramsize=600 \
		-u admin -p password

		/opt/couchbase/bin/couchbase-cli bucket-create \
		-c 127.0.0.1:8091 \
		--bucket=default \
		--bucket-type=couchbase \
		--bucket-port=11211 \
		--bucket-ramsize=600 \
		--bucket-replica=1 \
		-u Administrator -p password
fi

while true ; do continue ; done