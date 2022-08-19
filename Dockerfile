FROM debian:bullseye

RUN apt-get update \
    && apt-get install -y \
    sudo \
    curl \
    git \
    file \
    procps

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN useradd -G sudo -m debian

WORKDIR /home/debian
USER debian

CMD ["bash"]

ENV NONINTERACTIVE=true

