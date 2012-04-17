#!/bin/bash

repair()
{
    A=`stat ${1}/data/mongod.lock | sed -ne 's/^  Size: \([0-9]\+\) .*/\1/p'`
    if [ $A -ne 0 ]; then
	rm ${1}/data/mongod.lock
	/var/vcap/packages/mongodb/bin/mongod --repair -f ${1}/mongodb.conf
    fi
}

cd /var/vcap/store/mongodb
for i in `ls .`
do
repair $i
done
