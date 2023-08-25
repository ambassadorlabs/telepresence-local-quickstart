# telepresence-local-quickstart
Code to set up a local cluster with Traffic Manager and the Edgey Corp sample app.

This repository is meant to be used with the [Telepresence quickstart documentation](https://www.getambassador.io/docs/telepresence/latest/quick-start).

## Cloning
This repo includes a submodule with a sample app. Please clone using
```shell
$ git clone git@github.com:ambassadorlabs/telepresence-local-quickstart.git --recurse-submodules
```

## Using this repository

There are three prerequisite tools for using this repository:
* [Docker](https://docs.docker.com/get-docker/)
* [kubectl](https://kubernetes.io/docs/tasks/tools/)
* [Telepresence](https://www.getambassador.io/docs/telepresence/latest/install)

We do not install these tools as part of the script because they are likely to be tools you already use or that
you will use long-term and they should be installed by your preferred method. If you do not already have them,
please visit the links above to the install pages for each tool.

This script also looks to see if you have [Kind](https://kind.sigs.k8s.io/) installed to create a local cluster.
If you already have it installed the script takes no action, otherwise it downloads the binary to the local directory
and runs it from there, to avoid needing `sudo` or `Administrator` privileges.

There are three install scripts and three removal scripts, one each for Linux, MacOS and Windows.
To get started, just run

```shell
./<operating system>-setup.sh
```

```powershell
.\windows-setup.ps1
```

where operating system is `macos`, `linux` or `windows`.

Then continue on with the [Telepresence quickstart documentation](https://www.getambassador.io/docs/telepresence/latest/quick-start).

### Removal

When you are done, if you'd like to remove what we installed, simply run the appropriate `<operating system>-remove` script, which will delete the cluster and remove the Kind binary.
