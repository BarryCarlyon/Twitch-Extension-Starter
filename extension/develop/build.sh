#!/bin/bash

rm -r ../../release/*

mkdir ../../release/viewer
mkdir ../../release/config

#assets
mkdir ../../release/assets
cp -r assets/* ../../release/assets/.

#config
html-minifier \
    --collapse-whitespace \
    --remove-comments \
    --remove-empty-attributes \
    config/index.html >../../release/config/index.html

echo 'ok config html'

uglifycss \
    common/reset.css \
    common/fonts.css \
    config/config.css \
    > \
    ../../release/config/config.min.css

echo 'ok config css'

terser \
    --compress drop_console=true \
    common/common.js \
    config/config.js \
    >../../release/config/config.min.js

echo 'ok config js'

#view
html-minifier \
    --collapse-whitespace \
    --remove-comments \
    --remove-empty-attributes \
    viewer/index.html >../../release/viewer/index.html

echo 'ok viewer html'

uglifycss \
    common/reset.css \
    common/fonts.css \
    viewer/viewer.css \
    > \
    ../../release/viewer/viewer.min.css

echo 'ok viewer css'

terser \
    --compress drop_console=true \
    common/common.js \
    viewer/viewer.js \
    >../../release/viewer/viewer.min.js

echo 'ok viewer js'

# clean interim
cd ../../release/
zip -r assets.zip *

echo 'Done'
