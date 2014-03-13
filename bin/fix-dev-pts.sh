#!/bin/sh

mount -n -t devpts -o remount,mode=0620,gid=5 devpts /dev/pts
