#!/bin/bash -e

IMAGE='itermcolors:latest'

if [[ -z "$(docker images -q "$IMAGE" 2> /dev/null )" ]] ; then # create the image
    docker build -t "$IMAGE" .
fi
if [[ $1 == debug ]] ; then # We want to debug
    echo ">>> Debug. This will be executed:"
    ENTRYPOINT=$(grep '^ENTRYPOINT' Dockerfile | sed 's/ENTRYPOINT //')
    COMMANDS=$(echo "$ENTRYPOINT" | sed -E 's/.*", "//' | sed 's/"]//')
    echo "$COMMANDS" | sed 's/ && /& \n/g'
    echo
    exec docker run --rm -it -v ".:/colors" --entrypoint /bin/bash "$IMAGE"
fi
exec docker run --rm -it -v ".:/colors" "$IMAGE"
