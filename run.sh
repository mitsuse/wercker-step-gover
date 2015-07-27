#!/bin/bash

report_name=${WERCKER_GOVER_REPORT}
base_package=${WERCKER_GOVER_PROJECT}
base_path=${GOPATH}/src/${base_package}
coverprofile_path=/var/tmp/coverprofile-$(date +%s)

go get github.com/modocache/gover

if [ ! -d ${coverprofile_path} ]
then
    mkdir ${coverprofile_path}
else
    rm ${coverprofile_path}/*.coverprofile
fi

for package in $(go list ${base_package}/...)
do
    cover_name=$(echo ${package} | sed -e "s/\//__/g").coverprofile
    cover_path=${coverprofile_path}/${cover_name}
    go test -covermode=count -coverprofile=${cover_path} ${package}
done

gover ${coverprofile_path} ${report_name}
