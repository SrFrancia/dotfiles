#!/bin/bash
apt update
apt install curl gcc make clangd python3 python3-venv python-is-python3 pip lua5.4 luarocks ripgrep fd-find
python3 -m pip install --user --upgrade pynvim
