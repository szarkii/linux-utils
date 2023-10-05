# linux-utils
Debian repository with util scripts for Linux.

## Setup

### Add repository

File: `/etc/apt/sources.list`

```
deb [trusted=yes] http://sample-url.com/debian ./
```

# Applications

## frames-from-vid

Generates images from a video with a 1 second frequency. Can remove the same images to leave only the unique ones.

**Technology**: bash, python (for uniquness)

**Dependencies**: images-difference

## images-difference

Detects if a provided images are similar.

**Technology**: python

**Dependencies**: cv2

## motion-detector

Detects movement and records if detected.

**Technology**: python

**Dependencies**: cv2

## music-metadata

Sets metadata for the music files. Downloads a file if needed.

**Technology**: bash

**Dependencies**: youtube-dl, kid3-cli

## shred-all

Wrapper for a `shred`. Allows to shred whole dictionaries recursively. Could also show the progress of shredding the files.

**Technology**: bash

## concat-video

Concatenate two or more video files.

**Technology**: bash

**Dependencies**: ffmpeg