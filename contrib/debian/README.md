
Debian
====================
This directory contains files used to package opcxd/opcx-qt
for Debian-based Linux systems. If you compile opcxd/opcx-qt yourself, there are some useful files here.

## opcx: URI support ##


opcx-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install opcx-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your opcxqt binary to `/usr/bin`
and the `../../share/pixmaps/opcx128.png` to `/usr/share/pixmaps`

opcx-qt.protocol (KDE)

