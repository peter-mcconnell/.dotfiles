FROM ubuntu:20.04
LABEL maintainer "Peter McConnell <me@petermcconnell.com>"

ENV TZ=Europe/Dublin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update -yq && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -yq --no-install-recommends \
      sudo \
      make && \
    rm -rf /var/lib/apt/lists/*

COPY . /workspace/
WORKDIR /workspace/

RUN make install

CMD ["bash"]
