# Server

The server is expected to be put behind SSL (ngrok or the like)

Then you need to populate the CSP configuration

The `clientID` is the base requirement. More jsut to ensure that it matches

But `imgSrc`/`mediaSrc`/`connectSrc` to mimic Twitch's dev console settings and test in "localtest" to make the CSP be closed to Twitch's hosted/release as possible

Generally `connectSrc` is gonna be the minimum so your Extension can talk to your EBS/backend service

# Server Operation

`chokidar` watches the `develop` folder, and when changes are spotted kicks off the `script.sh`

That basically just takes everything in `develop` to create a "similar to release" build in the build folder.

My approach here is usally a bunch of JS/CSS files that are then concatenated and uglified. But at the `develop` stage leaves in console.

A globally installed

-   `terser` to tidy JavaScript
-   `uglifycss` to tidy CSS
-   `html-minifier` to tidy HTML

are used for those operations.

Remember to check that `script.sh` is excutable.

The example `script.sh` here buids a `config` and a `viewer` views. It will also copy/deploy assets from the `develop` assets folder.

# Build

The `build.sh` script is used to prepare a build and zip file for upload.

Broadly the same as `script.sh` but adds `compress` and `drop_console` to terser configuration.

And builds a zip at the end, that zip is what you upload to the Twitch Dev console for hosted test purpose

# Folders

Code is made in `develop`
The dev build script deploys into `build`
And is hosted from that foldrer

The release script builds a release into the `release` folder
That zip in there is then uploaded to Twitch for hosted test/actual release

# After release

Then when done copy the `release` folder into `released` and rename to the version queued/released as

And I'll generally

> cp -r release released/${version}
> cp -r develop/dev develop/${version}

And git commit that to keep the dev and release builds around
