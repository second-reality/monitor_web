FROM debian:trixie

RUN apt update && apt install -y cutycapt elinks xvfb
RUN apt update && apt install -y openvpn gpg curl
RUN useradd user --create-home
