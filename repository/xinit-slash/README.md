ABOUT
=====

A generic .xinitrc config loader. Enables dotfiles modularity.
Each dotfile can place it's own config into pool by placing script
in designed directory:

* $HOME/.slash/etc/X11/xinit/xinitrc.d/\*.sh

Allows execute program on X startup. Files MUST HAVE .sh extention
Order is realized by "NUMBER-" prefix.

E.g.
100-dunst.sh
999-start-fluxbox.sh

* $HOME/.slash/etc/X11/xinit/Xresources.d/\*

Alters Xresource configuration. Each file has "Xresource-" prefix
to allow vim coloring, following by next affix "NUMBER-" to order
files.

E.g.
Xresource-100-urxvt
Xresource-200-hidpi
