# linux-utils
Debian repository with util scripts for Linux.

## Setup

### Add repository Ubuntu >= 24.04

File:

```
/etc/apt/sources.list.d/ubuntu.sources
```

Content:

```
Types: deb
URIs: http://sample-url.com/debian
Suites: ./
Components:
Trusted: yes
```

### Add repository Ubuntu <= 22.04

File:

```
/etc/apt/sources.list
```
Content:
```
deb [trusted=yes] http://sample-url.com/debian ./
```

# Applications

## concat-video

Merges video files into one.

```
concat-video [-o | --output name] file1 file2 [file3 ...]
  -o  output file name (first + last file names by default)
```

**Technology**: bash

**Dependencies**: ffmpeg

## delete-old-files

Keeps the folder free of files not used for a long time. Creates a log file with deleted files for a track purposes.

```
delete-old-files <directory> <days>
Delete files older than a given time. Example:
   delete-old-files ~/tmp 30
```

**Technology**: bash

**Dependencies**: -

## enc

Encrypts file with AES-256.

```
enc [[-d | --decrypt] | [-p | --print]] <file>
```

**Technology**: bash

**Dependencies**: openssl

## frames-from-vid

Generates images from a video with a 1 second frequency. Can remove the same images to leave only the unique ones.

```
frames-from-vid [-u] [-t threshold] video [video2, video3, ...]
   -u  delete the same frames and leave only unique ones
   -t  similarity threshold, lower more accurate, only if -u specified
```

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

```
music-metadata [-s | --show] [-o output] [-t track] [-n name] [-a artist] [-l album] [-y year] [-g genre] input [input2, ...]
   input  file or URL
   -n  will be also the name of file if input is URL (if empty the title will be used)
   -o  output directory (if downloading file)
   -s  only show metadata
```

**Technology**: bash

**Dependencies**: youtube-dl, kid3-cli

## shred-all

Wrapper for a `shred`. Allows to shred whole dictionaries recursively. Could also show the progress of shredding the files.

```
shred-all [-p | --progress] file1 [file2 directory ...]
```

**Technology**: bash

## wipe-disk

Creates a file and fills it with zero in order to fulfill the remaining space and override existing data.

```
wipe-disk mount-point
    mount-point    e.g. /media/user/pendrive
```

**Technology**: bash

**Dependencies**: dd, df
