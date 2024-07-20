#!/bin/bash

set -e

npx spago bundle

$(npx mocha output/bundle.js > output/test-output.txt) || echo "Checking test output..."

fail() {
    echo -e "\nTests output:\n"
    cat output/test-output.txt
    exit 1
}

test_single() {
    str="$1"
    echo -n "${str}? "
    if ! grep -q "$str" output/test-output.txt; then
        echo "Nope."
        fail
    else
        echo "Yes!"
    fi
}

test_single "2 passing"
test_single "1 pending"
test_single "2 failing"
