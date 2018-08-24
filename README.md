# Node.js with npm, Yarn and N|Solid

[![Docker Build Status](https://img.shields.io/docker/build/gokaygurcan/node.svg?style=for-the-badge&logo=docker&colorA=22b8eb)](https://hub.docker.com/r/gokaygurcan/node/) [![Travis CI](https://img.shields.io/travis/gokaygurcan/dockerfile-node.svg?style=for-the-badge&logo=travis&colorA=39a85b)](https://travis-ci.org/gokaygurcan/dockerfile-node) [![MicroBadger](https://img.shields.io/microbadger/image-size/gokaygurcan/node.svg?style=for-the-badge&colorA=337ab7&colorB=252528)](https://microbadger.com/images/gokaygurcan/node)

<h2>Environment variables</h2>

| Name         | Value         |
| ------------ | ------------- |
| USR_SRC_NODE | /usr/src/node |
| NS_NODE      | node_8.x      |
| NS_NSOLID    | nsolid_3.x    |
| NS_DISTRO    | bionic        |

<h2>Additional packages</h2>

- lsb-release

<h2>CMD</h2>

```bash
node
```

<h2>Usage</h2>

To pull the image

```bash
docker pull gokaygurcan/node:latest

# or

docker pull gokaygurcan/node:carbon
```

---

[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/guidelines/download-assets-sm-2.svg)](https://www.buymeacoffee.com/gokaygurcan)
