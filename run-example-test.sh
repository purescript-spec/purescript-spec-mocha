#!/bin/bash

pulp browserify -I test --main Test.Main > output/bundle.js
mocha output/bundle.js
