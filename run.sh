#!/bin/sh

kpackagetool5 --remove src/package
kpackagetool5 --install src/package

plasmoidviewer --applet parker.mediacontrol

