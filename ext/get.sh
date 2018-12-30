#!/bin/bash

fn_abort()
{
    ERRCODE=$?
    echo >&2 "Error $ERRCODE executing $BASH_COMMAND on line ${BASH_LINENO[0]}"
    exit $ERRCODE
}

trap fn_abort ERR
set -o errtrace -o pipefail

fn_get()
{
    cd "$1/src"
    rm -f tmp.zip
    echo "$2"
    curl -s "$2" --output tmp.zip
    unzip -q tmp.zip
    rm -f tmp.zip
    cd "$1"
}

PWD=`pwd`
mkdir -p src

fn_get "$PWD" https://codeload.github.com/campisano/GenericMakefile/zip/master
fn_get "$PWD" https://codeload.github.com/SOCI/soci/zip/3.2.3

cp -a src/GenericMakefile-master/Makefile.inc .
