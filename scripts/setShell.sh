#! /bin/bash

# setting fish shell

command -v fish | sudo tee -a /etc/shells
chsh -s "$(command -v fish)"
