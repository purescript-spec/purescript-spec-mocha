#!/bin/bash

set -e

npx spago bundle-app --main Test.Main --to output/bundle.js

# need to disable-web-security in chromium to allow cross-origin requests
npx mocha-headless-chrome -f test/index.html -o output/test-output-headless.txt -a disable-web-security || echo "Checking test output..."

fail() {
    echo -e "\nTests output:\n"
    cat output/test-output-headless.txt
    exit 1
}

test_single() {
    str="$1"
    echo -n "${str}? "
    if ! grep -q "$str" output/test-output-headless.txt; then
        echo "Nope."
        fail
    else
        echo "Yes!"
    fi
}

test_single "\"passes\":2"
test_single "\"pending\":1"
test_single "\"failures\":2"
