OPCX Core
=====================

Setup
---------------------
[OPCX Core](http://opcx.org/wallet) is the original OPCX client and it builds the backbone of the network. However, it downloads and stores the entire history of OPCX transactions; depending on the speed of your computer and network connection, the synchronization process can take anywhere from a few hours to a day or more. Thankfully you only have to do this once.

Running
---------------------
The following are some helpful notes on how to run OPCX on your native platform.

### Unix

Unpack the files into a directory and run:

- bin/32/opcx-qt (GUI, 32-bit) or bin/32/opcxd (headless, 32-bit)
- bin/64/opcx-qt (GUI, 64-bit) or bin/64/opcxd (headless, 64-bit)

### Windows

Unpack the files into a directory, and then run opcx-qt.exe.

### OSX

Drag OPCX-Qt to your applications folder, and then run OPCX-Qt.

### Need Help?

* See the documentation at the [OPCX Wiki](https://en.bitcoin.it/wiki/Main_Page) ***TODO***
for help and more information.
* Ask for help on [BitcoinTalk](https://bitcointalk.org/index.php?topic=1262920.0) or on the [OPCX Forum](http://forum.opcx.org/).
* Join one of our Slack groups [OPCX Slack Groups](https://opcx.org/slack-logins/).

Building
---------------------
The following are developer notes on how to build OPCX on your native platform. They are not complete guides, but include notes on the necessary libraries, compile flags, etc.

- [OSX Build Notes](build-osx.md)
- [Unix Build Notes](build-unix.md)
- [Gitian Building Guide](gitian-building.md)

Development
---------------------
The Pivx repo's [root README](https://github.com/OPCX-Project/OPCX/blob/master/README.md) contains relevant information on the development process and automated testing.

- [Developer Notes](developer-notes.md)
- [Multiwallet Qt Development](multiwallet-qt.md)
- [Release Notes](release-notes.md)
- [Release Process](release-process.md)
- [Source Code Documentation (External Link)](https://dev.visucore.com/bitcoin/doxygen/) ***TODO***
- [Translation Process](translation_process.md)
- [Unit Tests](unit-tests.md)
- [Unauthenticated REST Interface](REST-interface.md)
- [Dnsseed Policy](dnsseed-policy.md)

### Resources

* Discuss on the [BitcoinTalk](https://bitcointalk.org/index.php?topic=1262920.0) or the [OPCX](http://forum.opcx.org/) forum.
* Join the [OPCX-Dev](https://opcx-dev.slack.com/) Slack group ([Sign-Up](https://opcx-dev.herokuapp.com/)).

### Miscellaneous
- [Assets Attribution](assets-attribution.md)
- [Files](files.md)
- [Tor Support](tor.md)
- [Init Scripts (systemd/upstart/openrc)](init.md)

License
---------------------
Distributed under the [MIT/X11 software license](http://www.opensource.org/licenses/mit-license.php).
This product includes software developed by the OpenSSL Project for use in the [OpenSSL Toolkit](https://www.openssl.org/). This product includes
cryptographic software written by Eric Young ([eay@cryptsoft.com](mailto:eay@cryptsoft.com)), and UPnP software written by Thomas Bernard.
