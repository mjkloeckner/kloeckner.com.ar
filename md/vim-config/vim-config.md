% title: "vim - The keyboard driven text editor"
% date: "04-Mar-2021"

![Vim logo](vim_logo.png "Vim logo"){.article-icon}

# The keyboard driven text editor

If we think for a moment about software we are going to realize that the
core of every program is just plain text, literally, just words in a
file that someone wrote, this webpage it's just text interpreted by
your web-browser, whose also just plain text implemented by another
program, some software has more complexity than others, for example the
linux kernel it's estimated that has around 27.8 million lines of code,
which is also just plain text.

The way we tell computers what to do is with text, so in order to
write that text we need a set of basic tools, one of which is a text editor,
and this is were Vim it's known for. Vim is just a text editor.
The term Vim stands for Vi IMproved, Vim is a rewrite and improved version of Vi,
a text editor that dates from 1978.

In this article I want to show how this text editor became my best
frient (?), why I learned to love about Vim keybindings and now I even have
and extension on my browser to use vim like keybindings.

Vim is a console text editor (altough you can find distributions like
gvim, which comes with a gui), a benefit of this is that, It's very
lightweign in terms of system resources. Vim is also highly
configurable, you can do this by editing the *.vimrc* text
file, which should be in you home directory in Linux or BSD bases OSs,
if not, you can *create* a new blank one and start from zero.

If you installed Vim and you don't know how to move around or insert
text, first you need to understand the basics, Vim has 3 main "modes"

If you installed Vim and you don't know how to move around or insert
text, I'm only going to tell two things, first, how to exit, press esc
a couple of times and also Ctrl+C, just to make sure that you are on normal mode,
then type \`:wq\` and press enter. I'm also going to tell you how to
run vim tutor, which is a good tutorial included with vim which teaches you
how to use vim in an interactive way.

## Vim configuration

## Vim plugins

By default Vim comes with a lot of features missing, for example, a key
binding to comment a line, or auto close brackets, parenthesis, etc, this
features you can enable them by installing *plugins* which I
will cover leter.
