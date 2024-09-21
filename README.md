# linux-utils
Debian repository with util scripts for Linux.

## Setup

### Add repository

File: `/etc/apt/sources.list`

```
deb [trusted=yes] http://sample-url.com/debian ./
```

# Applications

## enc

Encrypts file with AES-256.

```
enc [[-d | --decrypt] | [-p | --print]] <file>
```

**Technology**: bash

**Dependencies**: openssl

## delete-old-files

Keeps the folder free of files not used for a long time. Creates a log file with deleted files for a track purposes.

```
delete-old-files <directory> <days>
Delete files older than a given time. Example:
   delete-old-files ~/tmp 30
```

**Technology**: bash

**Dependencies**:

## concat-video

Merges video files into one.

```
concat-video [-o | --output name] file1 file2 [file3 ...]
  -o  output file name (first + last file names by default)
```

**Technology**: bash

**Dependencies**: ffmpeg

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
