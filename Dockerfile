FROM ubuntu:latest

# SET NONINTERACTIVE
ENV DEBIAN_FRONTEND "noninteractive"

RUN apt update

RUN apt install -y \
    i3status \
    i3-wm \
    i3lock \
    i3 \
    compton \
    # bspwm \
    git \
    net-tools \
    python3 \
    rxvt-unicode \
    supervisor \
    ttf-dejavu \
    x11vnc \
    xorg \
    xserver-xorg

RUN apt install -y \
    xvfb

# noVNC setup
WORKDIR /usr/share/
RUN git clone https://github.com/kanaka/noVNC.git
WORKDIR /usr/share/noVNC/utils/
RUN git clone https://github.com/kanaka/websockify

RUN export DISPLAY=:0.0

COPY supervisord.conf /etc/

EXPOSE 8083

RUN useradd -m user
WORKDIR /home/user

# ENV SHELL=/bin/bash
# RUN mkdir -p /home/user/.config/bspwm
# COPY bspwmrc /home/user/.config/bspwm/
# COPY sxhkdrc /home/user/.config/bspwm/

CMD ["/usr/bin/supervisord"]
