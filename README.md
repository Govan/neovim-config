# Neovim Config

## Installation
`./install.sh` *should* get everything running on either macOS or Ubuntu.

## Docker
For safely experimenting with new options, a docker file gives us a sandbox.

```
docker build -f ./test/Dockerfile . -t neovim-sandbox
docker run --rm -it -v ${PWD}:/nvim neovim-sandbox /bin/bash
cd /nvim
./install.sh
```

Note that something is stopping me running the `install.sh` as part of the docker build, so
this step always has to be manually executed after the sandbox opens.

## Details
If I try to keep a readme out here it'll almost certainly fall out of step. The config file is/will be commented at length

