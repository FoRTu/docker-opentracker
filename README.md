# opentracker-docker 

Opentracker is a open and free bittorrent tracker. It aims for minimal resource usage and is intended to run at any GNU/Linux system. Currently it is deployed as an open and free tracker instance.

## How to run an _open_ opentracker
If you want to run a complete open tracker, just pull the docker image and start up a container:

`docker run -d --name opentracker -p 6969:6969/udp -p 6969:6969 lednerb/opentracker-docker`

This will bind the port `6969` to the docker container (UDP and TCP) and you're good to go.


## How to run a _customized_ opentracker instance

If you want to config your opentracker instance, just download or `git clone` the [github repository](https://github.com/Lednerb/opentracker-docker/) and edit the `opentracker.conf` file.

Now you have to build your own image as follows:
 1. Edit and save the `opentracker.conf` file
 2. Open a terminal and `cd` into the project folder
 3. Run `docker build -t yourfancyname/opentracker .`

After building the docker image successfully you can start up a container:

`docker run -d --name opentracker -p 6969:6969/udp -p 6969:6969 yourfancyname/opentracker`


## How to whitelist your opentracker torrents
If you solely want to run the opentracker instance for specific torrents you have to whitelist them.

Follow these steps to whitelist your .torrent files:
 1. Download or `git clone` the [github repository](https://github.com/Lednerb/opentracker-docker/)
 2. Open the `whitelist.txt` file in your favorite editor
 3. Copy & Paste your torrent `info_hashes` into the file
 4. Uncomment line 37 in the `opentracker.conf`
 5. Open a terminal and `cd` into the project folder
 6. Run `docker build -t yourfancyname/opentracker .`
 
Example whitelist.txt:
```
0123456789abcdef0123456789abcdef01234567
890123456789abcdef0123456789abcdef012345
```

After the docker image was successfully built you can start a new container:

`docker run -d --name opentracker -p 6969:6969/udp -p 6969:6969 yourfancyname/opentracker`

## How to blacklist some torrents
Just follow the steps from obove but paste the `info_hashes` into the `blacklist.txt` file and uncomment line 41 in the `opentracker.conf` file.

## Thanks & Donations
[Best wishes to the creators of opentracker!](http://erdgeist.org/arts/software/opentracker/)
opentracker is _beerware_ so feel free to donate those guys a drink ;-)
