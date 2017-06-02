# tklx/weechat - The extensible chat client
[![CircleCI](https://circleci.com/gh/tklx/weechat.svg?style=shield)](https://circleci.com/gh/tklx/weechat)

[WeeChat][weechat] is a fast, light and extensible chat client.


## Features

- Based on the super slim [tklx/base][base] (Debian GNU/Linux).
- Uses [tini][tini] for zombie reaping and signal forwarding.
- Includes weechat and weechat-plugins.
- Includes ``USER user`` to restrict the privileges of weechat.
- Includes ``EXPOSE 9001`` for optional relay configuration.

## Usage

```console
docker pull tklx/weechat

# non-persistent
docker run --rm -it tklx/weechat

# persistent settings, configuration, chat logs, etc.
mkdir -p ~/.weechat
docker run --rm -it -v ~/.weechat:/home/user/.weechat tklx/weechat
```

### Configuration

```
# configure freenode ssl
/server add freenode chat.freenode.net
/set irc.server.freenode.addresses "chat.freenode.net/7000"
/set irc.server.freenode.ssl on

# set your identity
/set irc.server.freenode.nicks your-nick
/set irc.server.freenode.username "your-username"
/set irc.server.freenode.realname "Your Real Name"

# connect to freenode and join a channel
/connect freenode
/join #channel-name
```

### Tips

```console
# weechat options
docker run --rm -it tklx/weechat --help

# interactive root terminal
docker run --rm -it -u root tklx/weechat /bin/bash
```

### Relay configuration / glowing bear (web UI)

Security notice:

* This sets up a non-encrypted relay.
* Access to the relay provides OS [execution privileges][relay-exec]!
* Use only for testing, and only on localhost.

```
# configure the relay and password
/relay add weechat 9001
/set relay.network.password secretrelaypassword

# get the container's IP address
$ docker ps
$ docker inspect -f '{{.NetworkSettings.IPAddress}}' CONTAINER-ID

# browse to http://glowing-bear.org and connect
```

## Automated builds

The [Docker image](https://hub.docker.com/r/tklx/weechat/) is built, and pushed by [CircleCI](https://circleci.com/gh/tklx/weechat) from source hosted on [GitHub](https://github.com/tklx/weechat).

* Tag: ``x.y.z`` refers to a [release](https://github.com/tklx/weechat/releases) (recommended).
* Tag: ``latest`` refers to the master branch.

## Issue Tracker

TKLX uses a central [issue tracker][tracker] on GitHub for reporting and
tracking of bugs, issues and feature requests.


[weechat]: https://weechat.org
[base]: https://github.com/tklx/base
[tini]: https://github.com/krallin/tini
[relay-exec]: https://github.com/weechat/weechat/issues/928
[tracker]: https://github.com/tklx/tracker/issues

