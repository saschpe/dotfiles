#!/bin/bash

MY_DIR=$(dirname `which $0`)
cd $MY_DIR
wget -O winetricks http://winetricks.org/winetricks
chmod +x winetricks
