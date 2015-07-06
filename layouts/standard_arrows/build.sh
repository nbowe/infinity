#!/bin/bash
# Default layout.

cmake -DCHIP=mk20dx128vlf5 -DScanModule=MD1 -DMacroModule=PartialMap \
      -DOutputModule=pjrcUSB -DDebugModule=full \
      -DBaseMap=defaultMap \
      -DDefaultMap="basic-0" \
      -DPartialMaps="basic-1" \
      /home/vagrant/controller

make clean
make
