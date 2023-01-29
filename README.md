# blobsaver-docker </br>
Docker container for [Blobsaver](https://github.com/airsquared/blobsaver)</br>
The only purpose of this container is to automatically grab blobs in the background on systems that can't really natively run blobsaver. </br>

## Setup </br>
You will need to already have a functional blobsaver.xml. Currently, this contaienr does not have the ability to generate it automatically. There are ways to get this, mainly being to just see if your distro has a supported blobsaver package and generating it from that. Otherwise, if you already know the needed details for blob saving functionality with Blobsaver, you can just make the XML yourself.</br>

By default, it will check every 5 minutes. You can change this by building it yourself. </br>

Find a place to store your blobs. Something like `/home/(user)/Documents/Blobs/`. This will be needed later. </br>

### Docker container </br>
```
docker run -d --name (container name) -v (path to blob directory):/blobsaver/blobs/ -e VERSION=(version) (image name)
```
| Operator | Need | Details |
|:-|:-|:-|
| `-d` | Yes | will run the container in the background. |
| `--name (container name)` | No | Sets the name of the container to the following word. You can change this to whatever you want. |
| `-v (path to blob directory):/blobsaver/blobs/` | Yes | Sets the folder that holds your blobs and the xml. This should be the place you just chose. Make sure your `blobsaver.xml` is in this location. |
| `-e VERSION=(version)` | Yes | Sets the version of Blobsaver that the container will download. Must be a supported version found on the Blobsaver. Use 3.5.0 at the minimum because that is when CLI functionality was added. |
| `(image name)` | Yes | The name of the image you built. |

#### Example:
```
docker run -d --name blobsaver-docker -v /host/lemon/Documents/Blobs/:/blobsaver/blobs/ -e VERSION=3.5.0 blobsaver-docker-image
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