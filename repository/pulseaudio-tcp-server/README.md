About
=====

Server-client configuration. Allows play sound simultaneously for
several users. Sound is not stopped when both users play sound or
when switching to different TTY.

Install
=======

Apply server config for user which will always be logged in. That
user will start the pulseaudio tcp server. Second user must aplly
client config. In additional all users (server and client) must
have same cookie file `~/.config/pulse/cookie`.

Troubleshooting
===============

No sound on client
* add both users server and client to sound group
* regenerete cookies and restart

Bluetooth
=========

Enable bluetooth service
Configuration for pulseaudio https://wiki.archlinux.org/index.php/Bluetooth#Audio
