# ddev-utilities docker image

## Overview

This utility image is a lightweight set of consistent Linux utilities, especially with

* base64
* bash
* jq
* shasum

To push it to latest, ./push.sh

## Instructions

This is most useful when something like a DDEV add-on cannot count on a utility like shasum or jq to be on the host side (or be a predictable version).

Instead of using `ddev describe -j | jq -r` for example, use `ddev describe -j | docker run -t ddev/ddev-utilities jq -r`

### base64

Instead of running `base64 -d` which may behave differently on different systems, use 
```bash
echo "somebase64content" | docker run -i --rm ddev/ddev-utilities base64 -d
```

### jq

`jq` is not available on all systems, but you can count on using it successfully with this image:

```bash
ddev describe -j | docker run -i --rm ddev/ddev-utilities jq -r .raw
```

### shasum

Instead of running shasum directly (its behavior can vary radically from system to system), use

```bash
echo $RANDOM | docker run -i --rm ddev/ddev-utilities shasum -a 256
```

### Building and pushing to Docker Hub

See [Use push.sh here](push.sh)

### Running
To run the container by itself:

```bash
docker run -it --rm ddev/ddev-utilities
```

## Source:

[https://github.com/ddev/ddev-utilities](https://github.com/ddev/ddev-utilities)

## Maintained by:

The [DDEV Docker Maintainers](https://github.com/ddev)

## Where to get help:

* [DDEV Community Discord](https://discord.gg/5wjP76mBJD)
* [Stack Overflow](https://stackoverflow.com/questions/tagged/ddev)

## Where to file issues:

https://github.com/ddev/ddev-utilities/issues

## Documentation:

https://github.com/ddev/ddev-utilities



