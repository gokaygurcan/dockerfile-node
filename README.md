# Node.js with npm, and Yarn

[![Docker Build Status](https://img.shields.io/docker/build/gokaygurcan/node.svg?style=for-the-badge&logo=docker&colorA=22b8eb)](https://hub.docker.com/r/gokaygurcan/node/) [![Travis CI](https://img.shields.io/travis/gokaygurcan/dockerfile-node.svg?style=for-the-badge&logo=travis&colorA=39a85b)](https://travis-ci.org/gokaygurcan/dockerfile-node) [![MicroBadger](https://img.shields.io/microbadger/image-size/gokaygurcan/node.svg?style=for-the-badge&colorA=337ab7&colorB=252528)](https://microbadger.com/images/gokaygurcan/node)

<h2>Environment variables</h2>

| Variable     | Value        |
| ------------ | ------------ |
| NODE_VERSION | 12.16.0      |

<h2>CMD</h2>

```bash
node
```

<h2>Usage</h2>

To pull the image

```bash
docker pull gokaygurcan/node:latest
```

And then,

```bash
docker run --rm gokaygurcan/node:latest node -e "console.log(process.versions);"
```
