FROM debian:buster-slim

ARG RUNNER_VERSION="2.273.0"
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get dist-upgrade -y && apt-get install -y curl jq

RUN curl -s https://get.docker.com | bash -s

WORKDIR /actions-runner

RUN \
  curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
  tar xzf actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
  rm actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
  ./bin/installdependencies.sh

COPY entrypoint.sh entrypoint.sh

RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
