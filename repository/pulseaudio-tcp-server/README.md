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

No sound
* Install pulseaudio-alsamixer

No sound on client
* add both users server and client to sound group
* regenerete cookies and restart

Error:

```
Oct 01 13:10:05 thinkpad systemd[1035]: pulseaudio.service: Scheduled restart job, restart counter is at 5.
Oct 01 13:10:05 thinkpad systemd[1035]: pulseaudio.service: Start request repeated too quickly.
Oct 01 13:10:05 thinkpad systemd[1035]: pulseaudio.service: Failed with result 'exit-code'.
Oct 01 13:10:05 thinkpad systemd[1035]: Failed to start Sound Service.
```

Configuration directory `~/.config/pulse` cannot by a symlink or has wrong permissions. Unlink/remove it, start the
service `systemctl --user start pulseaudio.service` so it will create new directory and than perform `sh stow.sh` to
apply config.

Bluetooth
=========

Enable bluetooth service
Configuration for pulseaudio https://wiki.archlinux.org/index.php/Bluetooth#Audio
