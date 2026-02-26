# octave
Docker images of GNU Octave with dependencies for Reproducible Analysis

[![Docker Image Version](https://img.shields.io/docker/v/reprostat/octave)](https://hub.docker.com/r/reprostat/octave) [![CircleCI](https://dl.circleci.com/status-badge/img/gh/reprostat/octave/tree/main.svg?style=shield)](https://dl.circleci.com/status-badge/redirect/gh/reprostat/octave/tree/main)

## Deployment of a new version

1. Edit the [building configuration](./build-conf.json).
   1. Change "OCTAVE_VERSION" to the new version
   2. Define the "BUILDER_VERSION" for the version based on the [Hierarchy of all available images](https://github.com/gnu-octave/docker/tree/main?tab=readme-ov-file#hierarchy-of-all-available-images).
2. Create a new Releas. Make sure the tag matches the version.

You can monitor the [CI/CD pipeline](https://app.circleci.com/pipelines/github/reprostat/octave), which builds, tests, and pushes the new image to [Docker Hub](https://hub.docker.com/repository/docker/reprostat/octave/tags).

