#!/bin/bash
# Default layout.

cmake -DCHIP=mk20dx128vlf5 -DScanModule=MD1 -DMacroModule=PartialMap \
      -DOutputModule=pjrcUSB -DDebugModule=full \
      -DBaseMap=defaultMap \
      -DDefaultMap="md1Overlay stdFuncMap" \
      -DPartialMaps="hhkbpro2" \
      /home/vagrant/controller

make clean
make
