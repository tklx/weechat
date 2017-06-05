# tklx/weechat - The extensible chat client
[![CircleCI](https://circleci.com/gh/tklx/weechat.svg?style=shield)](https://circleci.com/gh/tklx/weechat)

[WeeChat][weechat] is a fast, light and extensible chat client.


## Features

- Based on the super slim [tklx/base][base] (Debian GNU/Linux).
- Uses [tini][tini] for zombie reaping and signal forwarding.
- Configured with UTF-8 locale.
- Includes weechat, weechat-plugins and weechat-scripts.
- Includes off-the-record support (privacy).
- Includes [inwee][inwee] and useful snippets (convenience).
- Includes ``USER user`` to restrict the privileges of weechat.
- Includes ``EXPOSE 9001`` for optional relay configuration.

## Usage

```console
docker pull tklx/weechat

# non-persistent
docker run --rm -it -e TERM tklx/weechat

# non-persistent, applying all snippets
docker run --rm -it -e TERM tklx/weechat -r "/exec snippets/.inwee-all"

# persistent settings, configuration, chat logs, etc.
mkdir -p ~/.weechat
docker run --rm -it -e TERM -v ~/.weechat:/home/user/.weechat tklx/weechat

# weechat options
docker run --rm -it tklx/weechat --help

# interactive root terminal
docker run --rm -it -u root tklx/weechat /bin/bash
```

### Configuration

```
/exec inwee snippets/freenode
/exec inwee snippets/otr
/exec inwee snippets/colors
/exec inwee snippets/unicode
```

### Chatting on freenode

```
# set your identity
/set irc.server.freenode.nicks <nick>
/set irc.server.freenode.username <username>
/set irc.server.freenode.realname "Your Name"

# optional: if you would like to register your nick/username
/connect freenode
/msg NickServ REGISTER <password> <email>
/msg NickServ VERIFY REGISTER <username> <verificationcode-from-email>
/disconnect

# optional: setup authentication if you have a registered nick/username
/set irc.server.freenode.sasl_username <username>
/set irc.server.freenode.sasl_password <password>

# optional: autoconnect to freenode
/set irc.server.freenode.autoconnect on

# connect to freenode and join a channel
/connect freenode
/join #channel-name
```

### Using Off-The-Record

```
# start a private conversion (without encryption)
/query <nick>

# in the private chat buffer, start the encrypted session
/otr start

# for more information
/help otr
```

### Send commands and messages from host to weechat in container

```console
# set an environment variable for convenience
# in this example the container was started with "--name weechat"
inwee="docker exec -i -u user weechat inwee -d /dev/stdin"

# send a command
echo "/help" | $inwee

# send commands from a file
# e.g., you're using a non-persistent container and want to authenticate
cat freenode.creds | $inwee

# send a message to a specific buffer
# e.g., you need to share your audio device details to get help
lspci | grep -i audio | $inwee -b 'irc.freenode.#audiohelp'
```

### Relay configuration / glowing bear (web UI)

Security notice:

* This sets up a non-encrypted relay.
* Access to the relay provides OS [execution privileges][relay-exec]!
* Use only for testing, and only on localhost.

```
# configure the relay and password
/relay add weechat 9001
/set relay.network.password <secretrelaypassword>

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
[inwee]: https://github.com/susam/inwee
[relay-exec]: https://github.com/weechat/weechat/issues/928
[tracker]: https://github.com/tklx/tracker/issues

