#!/bin/sh

kpackagetool5 -g --remove src/package
kpackagetool5 -g -t Plasma/Applet --install src/package

plasmoidviewer --applet parker.mediacontrol

