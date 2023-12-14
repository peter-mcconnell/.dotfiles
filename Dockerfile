FROM ubuntu:22.04
LABEL maintainer "Peter McConnell <me@petermcconnell.com>"
SHELL ["/bin/bash", "-c"]

ENV TZ=Europe/Dublin
RUN useradd --create-home pete && \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
  apt-get update -yq --fix-missing && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -yq --no-install-recommends \
      sudo \
      ansible && \
  rm -rf /var/lib/apt/lists/* && \
  echo 'pete ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY . /home/pete/.dotfiles/
WORKDIR /home/pete/.dotfiles/

# Note: this isn't remotely a good idea for a Docker image ... if any stage of the ansible
#       playbook explodes, this entire docker layer is invalidated and you have to start
#       again. I'm doing this solely for two reasons:
#         - because I don't care enough if this image fails
#         - the effort splitting this into mulytple steps exceeds the value it returns
#       If you are looking at this file and thinking "Oh, I should do that for my ansible
#       playbook", stop - you almost certainly shouldn't.
RUN ansible-playbook playbook.yaml --extra-vars "hosts=local" -K
RUN rm -rf /tmp/*

CMD ["bash"]
