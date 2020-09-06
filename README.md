# GitHub Actions Runner

## Usage

```shell
docker run --rm --name runner \
    -e RUNNER_NAME=runner \
    -e ACCESS_TOKEN=token \
    -e ORGANIZATION=organization \
    -v /var/run/docker.sock:/var/run/docker.sock \
    quentinadam/github-actions-runner
```
