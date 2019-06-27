add_definitions(-DTRANSLATION_DOMAIN=\"plasma_applet_mediacontrol\")

set(MC_SRCS
    mediacontrol.cpp
)

add_library(plasma_applet_mediacontrol MODULE ${MC_SRCS})

kcoreaddons_desktop_to_json(plasma_applet_mediacontrol package/metadata.desktop SERVICE_TYPES plasma-applet.desktop)

target_link_libraries(plasma_applet_mediacontrol
                      Qt5::Gui
		      Qt5::Quick
		      Qt5::Qml
                      KF5::Plasma)

install(TARGETS plasma_applet_mediacontrol DESTINATION ${KDE_INSTALL_PLUGINDIR}/plasma/applets)

plasma_install_package(package parker.mediacontrol applet)
