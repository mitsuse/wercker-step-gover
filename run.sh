#!/bin/bash

report_name=${WERCKER_GOVER_REPORT}
exclude=${WERCKER_GOVER_EXCLUDE}
coverprofile_path=/var/tmp/coverprofile-$(date +%s)

go get github.com/modocache/gover

if [ ! -d ${coverprofile_path} ]
then
    mkdir ${coverprofile_path}
else
    rm ${coverprofile_path}/*.coverprofile
fi


if [ -n "$WERCKER_GOVER_EXCLUDE" ]; then
    for package in $(go list ./... | grep -vE "$WERCKER_GOVER_EXCLUDE")
    do
        cover_name=$(echo ${package} | sed -e "s/\//__/g").coverprofile
        cover_path=${coverprofile_path}/${cover_name}
        go test -covermode=count -coverprofile=${cover_path} ${package}
    done
    gover ${coverprofile_path} ${report_name}
else
    for package in $(go list ./...)
    do
        cover_name=$(echo ${package} | sed -e "s/\//__/g").coverprofile
        cover_path=${coverprofile_path}/${cover_name}
        go test -covermode=count -coverprofile=${cover_path} ${package}
    done
    gover ${coverprofile_path} ${report_name}
fi
