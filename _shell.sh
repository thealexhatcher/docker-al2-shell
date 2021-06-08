#!/bin/bash
set -e 
docker build -t al2_shell shell/.
DIR=$(pwd)
echo $DIR
docker run \
    --rm \
    --interactive \
    --tty \
    --privileged \
    --name al2_shell \
    --volume "$DIR":"/workspace" \
    --workdir "/workspace" \
    al2_shell "/bin/bash" 