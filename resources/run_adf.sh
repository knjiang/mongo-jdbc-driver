#!/bin/bash
#
# Usage: run_adf.sh <operation>
# operation: 'start' or 'stop'
#
# This script will start a local mongod and Atlas Data Federation instance, used for integration testing.
# The supported platforms are windows, macos, ubuntu1804, and rhel7.
#
# - To skip the download of ADF, set the environment variable HAVE_LOCAL_MONGOHOUSE to 1
#   and set the environment variable LOCAL_MONGOHOUSE_DIR to the root directory of the
#   mongohouse source tree.
# - To skip the operations of this script, set the environment variable SKIP_RUN_ADF to 1.

NAME=`basename "$0"`
if [[ $SKIP_RUN_ADF -eq 1 ]]; then
  echo "Skipping $NAME"
  exit 0
fi

ARG=`echo $1 | tr '[:upper:]' '[:lower:]'`
if [[ -z $ARG ]]; then
  echo "Usage: $NAME <operation>"
  echo "operation: 'start' or 'stop'"
  exit 0
fi

GO_VERSION="go1.22"
if [ -d "/opt/golang/$GO_VERSION" ]; then
  GOROOT="/opt/golang/$GO_VERSION"
  GOBINDIR="$GOROOT"/bin
elif [ -d "C:\\golang\\$GO_VERSION" ]; then
  GOROOT="C:\\golang\\$GO_VERSION"
  GOBINDIR="$GOROOT"\\bin
  export GOCACHE=$(cygpath -m $HOME/gocache)
  export GOPATH=$(cygpath -m $HOME/go)
# local testing macos
elif [ -e /usr/local/bin/go ]; then
  GOBINDIR=/usr/local/bin
elif [ -e /opt/homebrew/bin/go ]; then
  GOBINDIR=/opt/homebrew/bin
# local testing ubuntu
elif [ -e /home/linuxbrew/.linuxbrew/bin/go ]; then
  GOBINDIR=/home/linuxbrew/.linuxbrew/bin
else #local testing
  GOBINDIR=/usr/bin
fi


GO="$GOBINDIR/go"

echo $(which go)
echo "HELLO"
echo $(go version)
echo $(go env GOENV)
echo $GOBINDIR
echo $GOROOT
echo "GOODBYE"

PATH=$GOBINDIR:$PATH


cd $LOCAL_MONGOHOUSE_DIR

echo $($GO version)
