#!/bin/sh

kpackagetool5 --remove plasmoid
kpackagetool5 -t Plasma/Applet --install plasmoid

plasmoidviewer --applet ~/.local/share/plasma/plasmoids/parker.mediacontrol

