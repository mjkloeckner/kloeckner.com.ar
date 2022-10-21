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
lightweign in terms of system resources.

If you installed Vim and you don't know how to move around or insert
text, first you need to understand the basics, Vim has 3 main "modes"

If you installed Vim and you don't know how to move around or insert
text, I'm only going to tell two things, first, how to exit, press esc
a couple of times and also Ctrl+C, just to make sure that you are on normal mode,
then type \`:wq\` and press enter. I'm also going to tell you how to
run vim tutor, which is a good tutorial included with vim which teaches you
how to use vim in an interactive way.

## Vim configuration

Vim is also highly configurable, you can do configure vim by editing the *.vimrc*
text file, which should be in you home directory in Linux or BSD based OSs,
if not, you can *create* a new blank one and start from zero.

You can search for vim settings or copy from other's config files, you can also check
out my [vim config file](https://github.com/mjkloeckner/dotfiles/blob/master/.vimrc)
and take out the parts that would fit your needs. The basic settings are almost present
in every config file like:

```vim
set syntax=on
set encoding=utf-8
set tabstop=4
set shiftwidth=4
set number
set mouse+=a
```

## Vim plugins

By default Vim comes with a lot of features missing, for example, a key
binding to comment a line, or auto close brackets, parenthesis, etc, this
features you can enable them by installing *plugins*. Vim pluggins are
like strips of other's config files that you can include in yours.

The simpler way of managing pluggins is with a pluggin manager, I use
[vim-plug](https://github.com/junegunn/vim-plug).

### Installing a pluggin

First install vim-plug or any other vim plugging manager, for vim-plug enter
the link I left you above, and follow the instructions. For any other plugging manger
I think would be similar.

After you got a pluggin manager installed simply call the plugins that you want from
you .vimrc file, for example I'm using vim-plug and the section
where I call the pluggins in my .vimrc file looks like this:

```vim
Plug 'christoomey/vim-tmux-navigator'
Plug 'justinmk/vim-syntax-extra'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'alvan/vim-closetag'
Plug 'hankchiutw/nerdtree-ranger.vim'
```
