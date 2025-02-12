#!/bin/bash -e

IMAGE='itermcolors:latest'

if [[ $PWD == /colors ]] ; then # we are inside the container
    pip install -r requirements.txt
    cd tools
    ./gen.py
    python -m screenshot_gen
    python ./generate_screenshots_readme.py
else # we have to start the container
    if [[ -z "$(docker images -q "$IMAGE" 2> /dev/null )" ]] ; then # create the image
        docker build -t "$IMAGE" .
    fi
    docker run --rm -v "$PWD":/colors -w /colors "$IMAGE" /colors/generate-all.sh
fi
