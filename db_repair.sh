#!/bin/bash

repair()
{
    A=`stat ${1}/data/mongod.lock | sed -ne 's/^  Size: \([0-9]\+\) .*/\1/p'`
    if [ $A -ne 0 ]; then
	rm ${1}/data/mongod.lock
	/var/vcap/packages/mongodb/bin/mongod --repair -f ${1}/mongodb.conf
    fi
}

if [ $# -lt 1 ]; then
    echo "Usage: `basename $0` mongodb_data_dir1 [monogodb_data_dir2]  ... "
    echo "repair unporperly shutdown mongo database"
    exit 1
fi

for i in $@
do
repair $i
done
