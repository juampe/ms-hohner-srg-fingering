FROM debian:latest

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
     && apt-get -y install --no-install-recommends sudo bzip2 curl git markdown ca-certificates python3 python3-autopep8 python3-pip zip unzip make musescore

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
     && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME -s /bin/bash \
     && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
     && chmod 0440 /etc/sudoers.d/$USERNAME

