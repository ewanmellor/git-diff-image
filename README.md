git-diff-image
==============

This is an extension to 'git diff' that provides support for diffing images.

Platforms
---------

Only OS X at the moment.  Patches welcome!

Examples
--------

```
$ git diff
--- a/anImageThatHasChanged.jpg
+++ b/anImageThatHasChanged.jpg
@@ -1,5 +1,5 @@
 ExifTool Version Number         : 9.76
-File Size                       : 133 kB
+File Size                       : 54 kB
 File Access Date/Time           : 2015:05:02 20:01:21-07:00
 File Type                       : JPEG
 MIME Type                       : image/jpeg

$ git diff-image
# The same output as above, *and* a montage of the visual differences will be
# generated and opened in Preview.
```

![Screenshot](example-comparison.png?raw=true)


Installation
------------

Install exiftool and ImageMagick.  (The script will cope with these missing,
but it's not going to be very exciting without them.)

```
brew install exiftool imagemagick
```

Run the install script, which will configure your global git config for you.

Public domain dedication
------------------------

The files in this repository are by Ewan Mellor, and are dedicated
to the public domain. To the extent possible under law, Ewan Mellor
has waived all copyright and related or neighboring rights to this
work. http://creativecommons.org/publicdomain/zero/1.0/.
