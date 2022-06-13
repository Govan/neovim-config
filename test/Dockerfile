FROM ubuntu:22.04
RUN apt update -yqq
RUN apt upgrade -yqq
RUN apt install -yqq sudo \
                         curl \
                         git

RUN apt install -yqq neovim

COPY ./ /nvim/
