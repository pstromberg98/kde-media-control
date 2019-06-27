#!/bin/sh

kpackagetool5 --remove src/package
kpackagetool5 -t Plasma/Applet --install src/package

