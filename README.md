# appwrite_example

Appwrite and Flutter example application project.

## Getting Started

####Please install Appwrite backend and config app's url in 'app_state.dart' before run

####Android will use http://10.0.2.2/v1 as proxy to access to Appwrite from Android emulator 


```shell script
docker run -it --rm \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --volume "$(pwd)"/appwrite:/install/appwrite:rw \
    -e version=0.6.1 \
    appwrite/install
```
---
####For more information about Appwrite installation and Flutter SDK usage can follow links below

https://appwrite.io/docs/installation
https://appwrite.io/docs/getting-started-for-flutter
---