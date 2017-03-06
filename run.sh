#!/bin/bash

report_name=${WERCKER_GOVER_REPORT}
coverprofile_path=/var/tmp/coverprofile-$(date +%s)

go get github.com/modocache/gover

if [ ! -d ${coverprofile_path} ]
then
    mkdir ${coverprofile_path}
else
    rm ${coverprofile_path}/*.coverprofile
fi


if [ -n "$WERCKER_GOVER_EXCLUDE" ]; then
    GO_LIST=$(go list ./... | grep -vE "/vendor/|$WERCKER_GOVER_EXCLUDE")
else
    GO_LIST=$(go list ./... | grep -vE "/vendor/")
fi

for package in ${GO_LIST}
do
    cover_name=$(echo ${package} | sed -e "s/\//__/g").coverprofile
    cover_path=${coverprofile_path}/${cover_name}
    go test -covermode=count -coverprofile=${cover_path} ${package}
done
gover ${coverprofile_path} ${report_name}
