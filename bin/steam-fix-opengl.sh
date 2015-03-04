#!/bin/sh

for p in ~/.local/share/Steam ~/.steam ; do
    rm -f $p/ubuntu12_32/steam-runtime/amd64/lib/x86_64-linux-gnu/libgcc_s.so.1
    rm -f $p/ubuntu12_32/steam-runtime/amd64/usr/lib/x86_64-linux-gnu/libstdc++.so.6
    rm -f $p/ubuntu12_32/steam-runtime/i386/lib/i386-linux-gnu/libgcc_s.so.1
    rm -f $p/ubuntu12_32/steam-runtime/i386/usr/lib/i386-linux-gnu/libxcb.so.1
    rm -f $p/ubuntu12_32/steam-runtime/i386/usr/lib/i386-linux-gnu/libstdc++.so.6
done
