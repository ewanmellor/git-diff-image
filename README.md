git-diff-image
==============

This is an extension to 'git diff' that provides support for diffing images.
It can also be run as a direct CLI command for diffing two image files.

Platforms
---------

Only macOS and Linux at the moment.  Patches welcome!

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

$ diff-image anImageThatHasChanged1.jpg anImageThatHasChanged2.jpg
# The same as above, only using files on disk not git differences.
```

![Screenshot](example-comparison.png?raw=true)


Installation
------------

1. Install exiftool and either ImageMagick or GraphicsMagick with the
ImageMagick compatibility links. (The script will cope with these missing,
but it's not going to be very exciting without them).

   macOS:

   ```bash
   brew install exiftool imagemagick
   ```

   Debian / Ubuntu (new versions):
   ```bash
   sudo apt install exiftool imagemagick xdg-utils
   ```

   Debian / Ubuntu (older versions):

   ```bash
   sudo apt install exiftool imagemagick xdg-open
   ```

   Debian / Ubuntu (if using GraphicsMagick):
   ```bash
   sudo apt install exiftool graphicsmagick graphicsmagick-imagemagick-compat xdg-utils
   ```

   Arch Linux:
  
   ```bash
   pacman -S xdg-utils perl-image-exiftool imagemagick xorg-xdpyinfo
   ```

   openSUSE Tumbleweed:
  
   ```bash
   sudo zypper install exiftool ImageMagick xdg-utils bc
   ```
   
2. Run `./install.sh`, which will configure your global git config for you.
It will tell you what it's done, so it should look something like this:

```bash
~/git-diff-image $ ./install.sh
+ git config --global core.attributesfile '~/.gitattributes'
+ touch '/Users/yourname/.gitattributes'
+ echo '*.gif diff=image' >>'/Users/yourname/.gitattributes'
+ echo '*.jpeg diff=image' >>'/Users/yourname/.gitattributes'
+ echo '*.jpg diff=image' >>'/Users/yourname/.gitattributes'
+ echo '*.png diff=image' >>'/Users/yourname/.gitattributes'
+ git config --global alias.diff-image '!f() { cd -- "${GIT_PREFIX:-.}"; GIT_DIFF_IMAGE_ENABLED=1 git diff "$@"; }; f'
+ git config --global diff.image.command '~/git-diff-image/git_diff_image'
```

Git LFS
-------

If you are using Git LFS then you have some extra manual configuration.
This has been left as a manual step because you need to choose whether
to do this on a per-repository basis or set it in your global configuration.

Instead of the default configuration in `~/.gitattributes` which looks
like this:

```
*.png diff=image
```

You need to extend it to look something like this:

```
*.png filter=lfs diff=lfs diff=image merge=lfs -text
```

You can either do this in your `~/.gitattributes` or a `.gitattributes` file
at the root of each repository.

Public domain dedication
------------------------

The files in this repository are by Ewan Mellor, and are dedicated
to the public domain. To the extent possible under law, Ewan Mellor
has waived all copyright and related or neighboring rights to this
work. http://creativecommons.org/publicdomain/zero/1.0/.
