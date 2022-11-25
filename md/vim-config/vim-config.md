%%
title: "vim - The keyboard driven text editor"
date: "04-Mar-2021"
%%

![Vim logo](vim_logo.png "Vim logo"){.article-icon}

# The keyboard driven text editor

If we think for a moment about software we are going to realize that the
core of every program is just plain text, literally, just words in a
file that someone wrote, this webpage is just text interpreted by
your web-browser, whose also just plain text.

The way we tell computers what to do is with text, so in order to
write that text we need a set of basic tools, one of which is a text editor,
and this is were Vim is known for.

Vim is just a console text editor, "console" because vim can only be executed
from the commandline (altough you can find distributions like gvim, which has
it's own window), a benefit of this is that, it's very lightweight in terms of
system resources. The term Vim stands for Vi IMproved, Vim is a rewrite and
improved version of Vi, a console text editor that dates from 1978, it's very
similar to vim but with less features.

If you installed Vim and you don't know how to move around or insert text, I'm
only going to tell two things, first, how to exit, press esc a couple of times
and also Ctrl+C, just to make sure that you are on normal mode, then type
\`:wq!\` and press enter. I'm also going to tell you how to run vim tutor, just
execute \`vimtutor\` from the commandline. Vim tutor is a very good tutorial
included with vim, it teaches you how to use vim in an interactive way.

## Vim configuration

Vim is also highly configurable, you can do configure vim by editing the
*.vimrc* text file, which should be in you home directory in Linux or BSD based
OSs, if not, you can *create* a new blank one and start from zero.

You can search for vim settings or copy from other's config files, you can also
check out my [vim config
file](https://github.com/mjkloeckner/dotfiles/blob/master/.vimrc) and take out
the parts that would fit your needs. The basic settings are almost present in
every config file like:

```vim
set syntax=on
set encoding=utf-8
set tabstop=4
set shiftwidth=4
set number
set mouse+=a
```

## Vim plugins

By default Vim comes with a lot of features missing, for example, a key binding
to comment a line, or auto close brackets, parenthesis, etc, this features can
be enabled by installing *plugins*. 

Vim plugins are like pieces of other's config files that you can include in
yours. The simpler way of managing plugins is with a plugin manager, I use
[vim-plug](https://github.com/junegunn/vim-plug).

### Installing a plugin

First install vim-plug or any other vim plugin manager, for vim-plug enter the
link I left you above, and follow the instructions. For any other plugin manger
I think it would be pretty similar. After you got a plugin manager installed
simply call the plugins that you want from you .vimrc file, for example I'm
using vim-plug and the section where I call the plugins in my .vimrc file looks
like this:

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

then, in the case of vim-plug, you need to run `:PlugInstall` to install all the
new plugins added.
