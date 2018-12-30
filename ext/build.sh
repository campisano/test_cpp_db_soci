#!/bin/bash

fn_abort()
{
    ERRCODE=$?
    echo >&2 "Error $ERRCODE executing $BASH_COMMAND on line ${BASH_LINENO[0]}"
    exit $ERRCODE
}

trap fn_abort ERR
set -o errtrace -o pipefail

fn_build()
{
    BASE_DIR=$1
    NAME=$2
    DIR=$3
    CMAKEARGS=$4
    echo -e " * \\033[1;33m${NAME}\\033[0;39m"
    mkdir "${BASE_DIR}/${DIR}/build"
    cd "${BASE_DIR}/${DIR}/build"
    cmake ${CMAKEARGS} | grep -v -- '-- Detecting C' | grep -v -- '-- Check for working C' | grep -v -- '-- Looking for '
    make
    make install
    cd "${BASE_DIR}"
    echo
}

rm -rf soci
rm -rf src/soci-3.2.3/build/

PWD=`pwd`

fn_build "$PWD" "SOCI" "src/soci-3.2.3" "-DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=98 -DCMAKE_INSTALL_MESSAGE=NEVER -DWITH_BOOST=OFF -DWITH_DB2=OFF -DWITH_FIREBIRD=OFF -DWITH_MYSQL=OFF -DWITH_ODBC=OFF -DWITH_ORACLE=OFF -DWITH_POSTGRESQL=ON -DWITH_SQLITE3=OFF -DSOCI_EMPTY=OFF -DCMAKE_INSTALL_PREFIX=../../../soci ../src"
