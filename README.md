# ddev-utilities docker image

## Overview

This utility image is a lightweight set of consistent Linux utilities, especially with

* base64
* bash
* curl
* jq
* sed
* shasum
* wget
* yq

To push it to latest, run `./push.sh`

## Instructions

This is most useful when something like a DDEV add-on cannot count on a utility like shasum or jq to be on the host side (or be a predictable version).

Instead of using `ddev describe -j | jq -r` for example, use `ddev describe -j | docker run -t ddev/ddev-utilities jq -r`

Classic utilities that are often different and unreliable on macOS include `base64` and `sed`

### base64

Instead of running `base64 -d` which may behave differently on different systems, use:

```bash
echo "somebase64content" | docker run -i --rm ddev/ddev-utilities base64 -d
```

### curl

```bash
docker run -i --rm ddev/ddev-utilities curl -I https://ddev.com
```

### jq

`jq` is not available on all systems, but you can count on using it successfully with this image:

```bash
ddev describe -j | docker run -i --rm ddev/ddev-utilities jq -r .raw
```

### sed

`sed` often behaves differently in BSD-derived systems like `macOS`, so you can use it predictably like this:

ddev list -j | docker run -i --rm ddev/ddev-utilities bash -c "jq -r .raw | sed 's/ddev\\.site/tld/g'"

### shasum

Instead of running shasum directly (its behavior can vary radically from system to system), use

```bash
echo $RANDOM | docker run -i --rm ddev/ddev-utilities shasum -a 256
```

### wget

```bash
docker run -it --rm -v ./:/pwd -u $(id -u):$(id -g) -w /pwd ddev/ddev-utilities bash -c "wget -qO- https://github.com/ddev/ddev/releases/download/v1.23.4/ddev_shell_completion_scripts.v1.23.4.tar.gz | tar xz --strip-components=1"
```

### yq

`yq` is used to modify YAML files. Example to add simple post-start hook to DDEV:

```yaml
hooks:
    post-start:
        - exec-host: ddev mailpit
```

```bash
docker run -i --rm -v ./:/pwd -u $(id -u):$(id -g) -w /pwd ddev/ddev-utilities yq -I4 -i '.hooks."post-start"[0]."exec-host" = "ddev mailpit"' .ddev/config.yaml
```

### Building and pushing to Docker Hub

See [Use push.sh here](https://github.com/ddev/ddev-utilities/blob/main/push.sh)

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
