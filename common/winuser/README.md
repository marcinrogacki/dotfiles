ABOUT
=====
Setup PC for Window users.

ROOT SETUP
==========

Disable "beep" sound on TTY/vconsole.

```
touch /etc/modprobe.d/nobeep.conf;
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf;
```

Autologin user on TTY1


```
mkdir -p /etc/systemd/system/getty@tty1.service.d/;
cd $_;
echo "[Service]" > override.conf;
echo "ExecStart=" >> override.conf;
echo "ExecStart=-/usr/bin/agetty --autologin username --noclear %I $TERM" >> override.conf;
```
