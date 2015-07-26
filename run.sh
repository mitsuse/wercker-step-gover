#!/bin/bash

report_name=${WERCKER_GOVER_REPORT}
base_package=${WERCKER_GOVER_PROJECT}
base_path=${GOPATH}/src/${base_package}

go get github.com/modocache/gover

if [ ! -d ${base_path}/coverprofile ]
then
    mkdir ${base_path}/coverprofile
else
    rm ${base_path}/coverprofile/*.coverprofile
fi

for package in $(go list ${base_package}/...)
do
    cover_name=$(echo ${package} | sed -e "s/\//__/g").coverprofile
    cover_path=${base_path}/coverprofile/${cover_name}
    go test -covermode=count -coverprofile=${cover_path} ${package}
done

gover ${base_path}/coverprofile ${report_name}
