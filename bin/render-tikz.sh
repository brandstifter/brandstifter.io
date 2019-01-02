#!/bin/bash

render_tikz() {
    echo "Render :: $0"
    OPWD="$(pwd)"
    BASE_DIR="$(dirname $0)"
    TIKZ_FILE="$(basename $0)"

    cd $BASE_DIR
    pdflatex $TIKZ_FILE
    rm -f *.log *.aux
    cd $OPWD
}

export -f render_tikz   # pass the function to subshell of find->exec
find . -type f -iname '*.tikz' -exec /bin/bash -c 'render_tikz "$1"' {} \;

