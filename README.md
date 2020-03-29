# opentracker-docker

Opentracker is a open and free bittorrent tracker. It aims for minimal resource usage and is intended to run at any GNU/Linux system. Currently it is deployed as an open and free tracker instance.

## How to run Opentracker
First of all you have to set the configuration file *opentracker.conf*. You can use [this as a template](opentracker.conf) if you want, or create a new file. *Opentracker* can be run in open-mode or limit it with hashes blacklist or whitelist.

## Run it in *open-mode*
In this mode any hash request will be recorded. Just add the tracker url to any torrent and when the bittorrent client request for peers,  it will record the hash and served on future requests.

Copy the [opentracker.conf file](opentracker.conf) as it is on a folder share the path with the container changing */PATH/CONFIG_FILE/* in the *docker run*:

`docker run -d --name opentracker -p 6969:6969/udp -p 6969:6969/tcp -v /PATH/CONFIG_FILE/:/etc/opentracker/ fortu/docker-opentracker`

## How to whitelist your opentracker torrents
If you solely want to run the opentracker instance for specific torrents you have to whitelist them.

Follow these steps to whitelist your .torrent files:
 1. Create a `whitelist.txt` file.
 2. Copy and paste your torrent `info_hashes` into the file:

     Example *whitelist.txt*:
     ```
     0123456789abcdef0123456789abcdef01234567
     890123456789abcdef0123456789abcdef012345
     ```

 3. Uncomment line 37 in the [opentracker.conf](opentracker.conf):

     ... *access.whitelist /etc/opentracker/whitelist.txt*

 4. Copy those files, *opentracker.conf* and *whitelist.txt*, to a folder.

Replace in the *docker run* command the path of the folder:

`docker run -d --name opentracker -p 6969:6969/udp -p 6969:6969/tcp -v /PATH/CONFIG_FILE/:/etc/opentracker/ fortu/docker-opentracker`

## How to blacklist some torrents
Just follow the steps from obove but paste the `info_hashes` into the `blacklist.txt` file and uncomment line 41 in the `opentracker.conf` file.

## Thanks & Donations
[Best wishes to the creators of opentracker!](http://erdgeist.org/arts/software/opentracker/)
opentracker is _beerware_ so feel free to donate those guys a drink ;-)

Thanks to [Sascha Brendel](https://github.com/Lednerb) for create the image I have forked.
