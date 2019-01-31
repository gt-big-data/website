set -e

# Install imagemagic
apk --update add imagemagick

# Install node libraries
npm install --global --quiet node-sass uglifycss

# Inspired by frolvlad
# https://hub.docker.com/r/frolvlad/alpine-python3/