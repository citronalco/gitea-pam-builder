# Gitea-with-PAM Builder

Unfortunately official binaries for Gitea do not support PAM authentication.\
This Docker container builds the latest Gitea release with PAM support for Debian based Linux distributions (Debian/Ubuntu/Mint).

## Prerequisites:
Linux machine with installed Docker (Debian/Ubuntu/Mint: `sudo apt-get install docker.io`)

## Instructions:
1. Run `./start.sh`
2. Wait
3. Get the binary from the directory `./binary/`

## PAM set up in Gitea
See https://docs.gitea.io/en-us/authentication/#pam-pluggable-authentication-module

You may use "login" as "PAM Service Name".
