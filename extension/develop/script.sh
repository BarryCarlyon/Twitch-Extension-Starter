#!/bin/bash

rm -r ../../build/*

mkdir ../../build/viewer
mkdir ../../build/config

#assets
mkdir ../../build/assets
cp -r assets/* ../../build/assets/.

#config
html-minifier \
    --collapse-whitespace \
    --remove-comments \
    --remove-empty-attributes \
    config/index.html >../../build/config/index.html

echo 'ok config html'

uglifycss \
    common/reset.css \
    common/fonts.css \
    config/config.css \
    > \
    ../../build/config/config.min.css

echo 'ok config css'

terser \
    common/common.js \
    config/config.js \
    >../../build/config/config.min.js

echo 'ok config js'

#view
html-minifier \
    --collapse-whitespace \
    --remove-comments \
    --remove-empty-attributes \
    viewer/index.html >../../build/viewer/index.html

echo 'ok viewer html'

uglifycss \
    common/reset.css \
    common/fonts.css \
    viewer/viewer.css \
    > \
    ../../build/viewer/viewer.min.css

echo 'ok viewer css'

terser \
    common/common.js \
    viewer/viewer.js \
    >../../build/viewer/viewer.min.js

echo 'ok viewer js'

echo 'Done'
