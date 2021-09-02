FROM ubuntu:20.04
LABEL maintainer "Peter McConnell <me@petermcconnell.com>"

RUN apt-get update -yq && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -yq --no-install-recommends \
      make && \
    rm -rf /var/lib/apt/lists/*

COPY . /workspace/
WORKDIR /workspace/

CMD ["bash"]
