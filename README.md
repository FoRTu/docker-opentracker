# OpenTracker Docker image
[![Docker Pulls count](https://img.shields.io/docker/pulls/fortu/opentracker.svg?label=Docker%20Pulls&color=brightgreen)](https://hub.docker.com/r/fortu/opentracker)

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

Replace in the *docker run* command below, the full path of the folder where you store the `opentracker.conf` and `whitelist.txt`:

```bash
docker run -d --name opentracker -p 6969:6969/udp -p 6969:6969/tcp -v /PATH/CONFIG_FILES/:/etc/opentracker/ fortu/opentracker
```

Now the bittorrent tracker is running and serving only the torrents that you want. If you want to add more torrents to your tracker, just stop the container, add the new `hash` to the `whitelist.txt` and start the container back.

Your tracker URL will be something like this:

`http://[YOUR PUBLIC IP OR DOMAIN]:6969/announce`

`udp://[YOUR PUBLIC IP ORDOMAIN]:6969/announce`

By default in the `opentracker.conf` file the *TCP* and *UDP* protocols are enabled. So you can use any of two urls. be sure that you have your firewall/NAT configured to recieve any request from the *6969* port in this case.

Also you can customize some configuration of the tracker by editing `opentracker.conf` file. For example, change the port *6969* by another one, force only the *TCP* or *UDP* protocols, enable stats and how to access to them etc.

## Customize the docker image
This docker image is build "as is", only to use with a *whitelist* of hashes as a personal bittorrent tracker. But you can build your own image if you want a totally open bittorrent tracker with a blacklist of hashes. This is usefull if you recieve a DMCA mail with a list of hashes that are infringing the copyright law.

Follow this steps to build your own public and open bittorrent tracker:

1. Clone the proyect:

  `git clone https://github.com/FoRTu/docker-opentracker.git`

2. Open the `Makefile` file and comment out the line below:

  ```bash
  #FEATURES+=-DWANT_ACCESSLIST_WHITE
  ```

3. Now uncomment the following lines:

  ```bash
  FEATURES+=-DWANT_ACCESSLIST_BLACK
  FEATURES+=-DWANT_COMPRESSION_GZIP
  FEATURES+=-DWANT_COMPRESSION_GZIP_ALWAYS
  FEATURES+=-DWANT_FULLSCRAPE
  ```

4. Save changes and close the file.

5. Staying in the same folder of the *Dockerfile*, run the build command:

  ```bash
  docker build --no-cache=true -t fortu/opentracker .
  ```

6. Create a `blacklist.txt` file within a folder and copy there the `opentracker.conf` file too. This folder should be accessible by the container once we run it.

7. Open the `opentracker.conf` file you just have copyed to change configuration.

8. Comment out the *whitlist* configuration line:

  ```bash
  #access.whitelist /etc/opentracker/whitelist.txt
  ```

9. Uncomment the *blacklist* configuration line:

  ```bash
  access.blacklist /etc/opentracker/blacklist.txt
  ```

10. You can change the listen port and the protocol you want to use in the tracker. For example in this case I'm going to enable only *UDP* protocol, instead both *TCP* & *UDP*, and change the port to *2571* . This will requiered to comment out the next line:

  ```bash
  #listen.tcp_udp 0.0.0.0:6969
  ```
  And add the next line below:

  ```bash
  listen.udp 0.0.0.0:2571
  ```

11. Is possible to enable the *stats* and the way of access to its. First of all is to enable it by uncommenting the next line and if you want haide or obfuscte the stats, just change the *path* too. In this case *mytrackerstats*:

  ```bash
  access.stats_path mytrackerstats
  ```

13. If someone tries to access your tracker using it as a website, they can be redirected to an *url*. Just change the last line and type the website you want to redirect them to:

  ```bash
  tracker.redirect_url http://www.TheWebSite.com/
  ```

14. Save changes and close the file.

15. Now you can run the next *docker run* command taking account of the changes you have done previously. You have to change the port number and the protocol you have define and the full path of the folder where you placed the `blacklist.txt` and the `opentracker.conf`files, were you have changed the configuration.

  ```bash
  docker run -d --name opentracker -p 2571:2571/udp -v /PATH/CONFIG_FILES/:/etc/opentracker/ fortu/opentracker
  ```

Now your bittorrent tracker is running and listening on the TCP/IP *port* and the protocol you have define. The only thing you have todo is to add the *URL* of your tracker to your torrent files or magnet links, and the tracker will start to serve it.

If you choose only *UDP* protocol and the *2571* port, the *URL* of the tracker will be like this:

`udp:\\[PUBLIC IP OR DOMAIN]:2571/announce`

But if you choose only the *TCP* or the both options, *TCP* & *UDP*, the url will be like this one:

`http:\\[PUBLIC IP OR DOMAIN]:2571/announce`

Is very important to open the *port* you have define on the configuration file in your *firewall* or make the necessary changes if you are behind a *NAT*. If you don't do it the requests that arrives from the internet won't be able to forward to your tracker.

If you had enable the stats you can access to them by any browser just typing the correct url. Be account to change port and the path you define in the configuration file:

`http://[PUBLIC IP O DOMAIN]:[PORT]/[PATH]?mode=everything`

For example:

`http://192.168.58.63:2571/mytrackerstats?mode=everything`


That's it!

You can find more information on the opentracker project website: [https://erdgeist.org/arts/software/opentracker/](https://erdgeist.org/arts/software/opentracker/)


## Thanks & Donations
[Best wishes to the creators of opentracker!](http://erdgeist.org/arts/software/opentracker/)
opentracker is _beerware_ so feel free to donate those guys a drink ;-)

Thanks to [Sascha Brendel](https://github.com/Lednerb) for create the image I have forked.
