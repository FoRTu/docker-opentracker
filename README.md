# OpenTracker Docker image

Opentracker is a open and free bittorrent tracker. It aims for minimal resource usage and is intended to run at any GNU/Linux system. Currently it is deployed as an open and free tracker instance.

## About this OpenTracker image
First of all, this tracker is compiled to use a *hash whitelist*, so only hashes stored on `whitelist.txt` are going to be served.

## How to run it
Follow these steps to enable your torrent hashes:
 1. Open `whitelist.txt` file and paste your torrents `info_hashes` into. One `hash` per line.

     Example *whitelist.txt*:
     ```
     0123456789abcdef0123456789abcdef01234567
     890123456789abcdef0123456789abcdef012345
     ```

 2. Copy those files, `opentracker.conf` and `whitelist.txt`, into a folder.

Replace in the *docker run* command the path of the folder:

`docker run -d --name opentracker -p 6969:6969/udp -p 6969:6969/tcp -v /PATH/CONFIG_FILE/:/etc/opentracker/ fortu/opentracker`

That's it!

Now the bittorrent tracker is running and serving only the torrents that you want. If you want to add more torrents to your tracker, just stop the container, add the new `hash` to the `whitelist.txt` and start the container back. Also you can customize some configuration of the tracker by editing `opentracker.conf` file.

## Thanks & Donations
[Best wishes to the creators of opentracker!](http://erdgeist.org/arts/software/opentracker/)
opentracker is _beerware_ so feel free to donate those guys a drink ;-)

Thanks to [Sascha Brendel](https://github.com/Lednerb) for create the image I have forked.
