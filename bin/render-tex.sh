#!/bin/bash

render_tex() {
    echo "Render :: $0"
    OPWD="$(pwd)"
    BASE_DIR="$(dirname $0)"
    TEX_FILE="$(basename $0)"

    cd $BASE_DIR
    pdflatex $TEX_FILE
    rm -f *.log *.aux
    cd $OPWD
}

export -f render_tex   # pass the function to subshell of find->exec
find . -type f -iname '*.tex' -exec /bin/bash -c 'render_tex "$1"' {} \;

