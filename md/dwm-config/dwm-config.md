% title: "dwm - A tiling window manager configuration"
% date: "23-Oct-2021"

# dwm - A tiling window manager configuration

A window manager is a software that can manage the layout and appearance
of every window spawned in your desktop, most people confuse them with
desktop enviroments, which isn't the same since a desktop enviroment is
more of an ecosystem, they come with a more 'complete' set of tools,
like a basic web browser, a terminal emulator or calculator, an example
of desktop enviroment would be gnome, xfce or kde plasma; instead a
window manager is only the program that manages the windows spawned,
although there are window managers that come with a little more, like
docks or taskbars (openbox for example).

In my case I use dwm, which is a window manager written in C developed
by suckless software. The most relevant thing of this window manager is
that out of the box it comes with the most basic functionallity, and if
you want to extend it you need to patch it.

By default dwm comes with 9 workspaces, in which you can open as many
windows as you please; to spawn a new window for example a web browser
you need to assign it a keybinding or use an application launcher like
[dmenu](https://tools.suckless.org/dmenu/)

[![Screenshot](screenshot.jpeg)](screenshot.png "Screenshot of my dwm build")

## Installing dwm

### Requisites

-   GNU/Linux or BSD based operating system
-   A C library and a C compiler
-   make utility installed
-   X server installed
-   dwm source code, you can clone the repository or download as a tar file at the web

As you can see above you can only install dwm on GNU/Linux or BSD based
distros, unfortunally dwm is not available for Windows users but I'm
sure there is an alternative.

### Installation

In order to install dwm you can visit the web of the creators at
[suckless.org/dwm](https://dwm.suckless.org/), where you can download
the source code as a tar file, or clone the repository.

After you obtain the source code you need to navigate to the root folder
of the source code and execute the following command

```console
$ sudo make install
```

after that you can log out of you user account, if you use a display
manager you can select dwm as window manager and log back in, if you
dont use a display manager you need to edit your .xinitrc file located
at you home folder so that when you start X dwm gets launched too, you
do this by adding \`exec dwm\` to the end of the .xinitrc
file, its important that you add it to the end of the file.

```console
$ cat $HOME/.xinitrc
exec dwm
```

Then you can start the X server by executing \`startx\` on a tty and it
should open dwm without any problems.

## How do you configure dwm?

Basically you configure it by editing its source code, inside the root
folder of the project there is a C header file named
[config.def.h](https://github.com/klewer-martin/dotfiles/blob/master/.config/dwm/config.def.h)
which if you open with a text editor you can see that there is some C
code that you can edit, for example the line \"static const int topbar\"
defines a variable named topbar which you can set to 1 or 0, to select
if the status bar should spawn in the top or the bottom of the screen.
After every change you make to the source code you need to copy
config.def.h to config.h and then recompile dwm

### Show information on the status bar

dwm by default won't show any information on the status bar, this is
done by using the xsetroot utility, which sets the WM\_NAME enviroment
variable that dwm uses, lets assume you want to set the clock and date
on the status bar, well you could execute the following command

```console
$ xsetroot -iname $(date)
```

and all the output of the command \`date\` would be printed on the status bar, this
makes dwm status bar highly scriptable, in fact there are a ton of status
bar implementations, the one that I use is called
[dwmblocks](https://github.com/torrinfail/dwmblocks) and its also
written in C and the configuration its pretty much the same as dwm, in
order to get information you need to have scripts that prints the
desired data to stdout, then you can include it on the config.h of
dwmblocks by having them on a folder which is included in the \$PATH
variable of your user.

### Getting emoji support on dwm

dwm by default doesn't come with emoji support, if you want to render
an emoji in the status bar its going to either show it as a box or in
the worst case crash, so in order to get emoji support first you need to
get a font with emojis, I'm using [JoyPixels®
font](https://www.joypixels.com/) you can also use
[Google's noto font](https://fonts.google.com/noto), or any other font
that comes with emoji support. Then open dwm configuration file and
append to the fonts array the name of the font you want,
in my case it's JoyPixels®.

```c
static const char *fonts[] = { "Source Code Pro:style=Regular:size=9",
								"JoyPixels:style=Regular:size=8",
								 "DejaVu Sans" };
```

After you setup the font you need to remove or comment a chunk of code
from drw.c, a file located in the root of the folder where dwm source
code resides, between lines 136-150 there is a function named IsCol, you
need to remove it or comment it.

Finally you can recompile dwm and you will get emoji support. Sometimes
even though you made all this procedure you still get boxes insted of
the proper emoji, I solved this by adding another font name in the
fonts array, like a fallback font.

### Patches in dwm

Since dwm is a simple program than doesn't include much features, if
you want to extend it, for example by adding a
[systray](https://dwm.suckless.org/patches/systray/) to the status bar,
you need to patch dwm. To do this first you need to download the patch
from [suckless.org/patches](https://dwm.suckless.org/patches/), then
make sure you got it 'patch' installed, although I think it comes with
most linux distributions by default nowdays.

```console
$ patch -p1 < <file.diff>
```

If you never patched dwm before then probably no errors would be
reportjd, but if you already have applied a ton of patches then probably
you would get a HUNK \## FAILED, in this case you need to get your hands
dirty, and manually patch all the files that failed, you do this by
opening the files with .rej extension (short for rejected), and the
corresponding file to be patched, for example dwm.c and dwm.c.rej, and
then you add all the chunks of code from the rejected file into the
corresponding place in the non rejected file, you know where you should
put the chunks of code because in the rej file you can see at the start
of every chunk there is a '@@' followed by a number of line; also
lines starting with plus means add, and minus means delete, if I'm not
clear you should google how to use diff and patch to modify a file.

## Useful links

- [What is a window manager?](https://en.wikipedia.org/wiki/Window_manager)
- Make sure to check the [suckless webiste](https://suckless.org/)
- [suckless dwm website](https://dwm.suckless.org/)
- [X server man page](https://www.x.org/releases/X11R7.7/doc/man/man1/Xserver.1.xhtml)
- [patch man page](https://man7.org/linux/man-pages/man1/patch.1.html)
