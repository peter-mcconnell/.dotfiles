FROM ubuntu:20.10
LABEL maintainer "Peter McConnell <me@petermcconnell.com>"
SHELL ["/bin/bash", "-c"]

ENV TZ=Europe/Dublin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
  apt-get update -yq && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -yq --no-install-recommends \
      sudo \
      make && \
    rm -rf /var/lib/apt/lists/*

COPY . /workspace/
WORKDIR /workspace/

RUN make install

CMD ["bash"]
