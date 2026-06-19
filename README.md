# octave
Docker images of GNU Octave with dependencies for Reproducible Analysis

[![Docker Image Version](https://img.shields.io/docker/v/reprostat/octave)](https://hub.docker.com/r/reprostat/octave)

## Deployment of a new version

1. Test image

    Go to the [testing workflow](https://github.com/reprostat/octave/actions/workflows/build-test.yml) and select "Run workflow". There you can also select the version yo want to test.

2. Biuld and publish the image

    Go to the [publishing workflow](https://github.com/reprostat/octave/actions/workflows/release-publish.yml) and select "Run workflow". There you can also select the version yo want to build and publish.

You can monitor the [CI/CD pipelines](https://github.com/reprostat/octave/actions), which builds, tests, and pushes the new image to
[Docker Hub](https://hub.docker.com/repository/docker/reprostat/octave/tags) and [GitHub Container Registry](https://ghcr.io/reprostat/octave).

