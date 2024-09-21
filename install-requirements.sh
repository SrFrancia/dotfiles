#!/bin/bash
apt update
apt install curl gcc make clangd python3 python3-venv python-is-python3 pip python3-pynvim lua5.4 luarocks ripgrep fd-find
# python3-pip install --user --upgrade pynvim ## replaced with apt install python3-nvim
