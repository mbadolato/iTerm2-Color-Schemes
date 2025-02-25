#!/bin/bash -e

IMAGE='itermcolors:latest'
COMMANDS=$( cat <<COMMANDS
    cd tools
    ./gen.py
    python -m screenshot_gen
    python ./generate_screenshots_readme.py
COMMANDS
)
if [[ $PWD == /colors ]] ; then # we are inside the container
    eval "$COMMANDS"
else # we have to start the container
    if [[ -z "$(docker images -q "$IMAGE" 2> /dev/null )" ]] ; then # create the image
        docker build -t "$IMAGE" .
    fi
    if [[ $1 == debug ]] ; then # We want to debug
        # Show the commands which would be run automatically
        echo ">>> Debug. These commands would be run:"
        echo "$COMMANDS"
        echo
        exec docker run --rm -v "$PWD":/colors -w /colors -it "$IMAGE"
    fi
    exec docker run --rm -v "$PWD":/colors -w /colors "$IMAGE" /colors/generate-all.sh
fi
