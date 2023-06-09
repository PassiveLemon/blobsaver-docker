# blobsaver-docker </br>

[![Repo](https://img.shields.io/badge/Docker-Repo-007EC6?labelColor-555555&color-007EC6&logo=docker&logoColor=fff&style=flat-square)](https://hub.docker.com/r/passivelemon/blobsaver-docker)
[![Version](https://img.shields.io/docker/v/passivelemon/blobsaver-docker/latest?labelColor-555555&color-007EC6&style=flat-square)](https://hub.docker.com/r/passivelemon/blobsaver-docker)
[![Size](https://img.shields.io/docker/image-size/passivelemon/blobsaver-docker/latest?sort=semver&labelColor-555555&color-007EC6&style=flat-square)](https://hub.docker.com/r/passivelemon/blobsaver-docker)
[![Pulls](https://img.shields.io/docker/pulls/passivelemon/blobsaver-docker?labelColor-555555&color-007EC6&style=flat-square)](https://hub.docker.com/r/passivelemon/blobsaver-docker)

Docker container for [Blobsaver](https://github.com/airsquared/blobsaver)</br>
The only purpose of this container is to automatically grab blobs in the background on systems that can't really natively run blobsaver. </br>

## Setup </br>
<b>You will need to already have a functional blobsaver.xml</b></br>
Currently, this container does not have the ability to generate it automatically. There are ways to get this, mainly being to just see if your distro has a supported blobsaver package and generating it from that. Otherwise, if you already know the needed details for blob saving functionality with Blobsaver, you can just make the XML yourself.</br>

Find a place to store your blobs. Something like `/home/(user)/Documents/Blobs/`. This will be needed later. </br>

I also highly recommend limiting the CPU usage of the container as when the program runs, it will spike your CPU usage. </br>

### Docker container </br>
```
docker run -d --name (container name) -v (path to blob directory):/blobsaver/blobs/ -e VERSION=(version) -e CRONTIME=(time in cron format) -e BLOBARG=(arguments for blobsaver) passivelemon/blobsaver-docker:latest
```
| Operator | Need | Details |
|:-|:-|:-|
| `-d` | Yes | will run the container in the background. |
| `--name (container name)` | No | Sets the name of the container to the following word. You can change this to whatever you want. |
| `-v (path to blob directory):/blobsaver/blobs/` | Yes | Sets the folder that holds your blobs and the xml. This should be the place you just chose. Make sure your `blobsaver.xml` is in this location. |
| `-e VERSION=(version)` | No | Sets the version of Blobsaver that the container will download. Must be a supported version found on the Blobsaver Github. Use 3.5.0 at the minimum because that is when CLI functionality was added. Defaults to 3.5.0 if not set. |
| `-e CRONTIME=(time in cron format)` | No | Sets the interval in which the cron job runs. Defaults to every 5 minutes if not set. (`*/5 * * * *`) |
| `-e BLOBARG=(arguments for blobsaver)` | No | Sets the arguments that Blobsaver will use when ran. Defaults to `--include-betas --background-autosave` if not set. Do not use `--import=/blobsaver/blobs/blobsaver.xml` or `--save-path=/blobsaver/blobs` as they are what set the directory for host mounting. |
| `passivelemon/blobsaver-docker:latest` | Yes | The repository on Docker hub. By default, it is the latest version that I have published. |

#### Example:
```
docker run -d --name blobsaver-docker -v /host/lemon/Documents/Blobs/:/blobsaver/blobs/ -e VERSION='3.5.0' -e CRONTIME='*/15 * * * *' -e BLOBARG='--background-autosave' passivelemon/blobsaver-docker:latest
```

### Xml </br>
An example XML file is provided in the repo. Make sure to remove the comments after the lines. </br>
```
<node name="#######">                                                                                 - The name that you want to put for the device.
  <map>
    <entry key="ECID" value="#############"/>                                                         - Your ECID. Can be found using 3rd party tools.
    <entry key="Save Path" value="/blobsaver/blobs/#######"/>                                         - The directory for that specific devices blobs to be saved. Must be prefixed with /blobsaver/blobs/ for it to save onto the host.
    <entry key="Device Identifier" value="#########"/>                                                - Your device identifer. https://ipsw.me/
    <entry key="Include Betas" value="true"/>                                                         - Set this to true to allow betas.
    <entry key="Apnonce" value="################################################################"/>   - Your Apnonce. Can be found using 3rd party tools.
    <entry key="Generator" value="0x################"/>                                               - Your generator. Can be found using 3rd party tools.
    <entry key="Save in background" value="true"/>                                                    - Set this to true so the blobs get saved automatically in the background.
```

### Other </br>
If you are getting high CPU Iowait use, check and make sure the container is working properly.