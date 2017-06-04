## 0.2.0

Off-the-record, UTF-8, inwee, convenience snippets

#### New features

- Support for off-the-record encrypted chats.
- Includes UTF-8 support for an improved weechat interface with unicode symbols.
- Conveniently send text/commands to weechat via [inwee](https://github.com/susam/inwee).
- Added convenience snippets (freenode, otr, colors, unicode).

#### Other changes

- Improved README documentation.

## 0.1.1

Expose 9001 for relay support

#### Notes

- Includes ``EXPOSE 9001`` for optional relay configuration.
- Updated README to include setup configuration and security notice.

## 0.1.0

Initial development release.

#### Notes

- Based off [tklx/base:stretch](https://github.com/tklx/base)
- Uses tini for zombie reaping and signal forwarding.
- Includes weechat and weechat-plugins.
- Includes ``USER user`` to restrict the privileges of weechat.

- Builds are automated via CircleCI:

    - Images tagged with ``latest`` are built from the master branch.
    - Images tagged with ``x.y.z`` refer to signed tagged releases.

