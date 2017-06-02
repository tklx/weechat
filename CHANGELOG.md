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

