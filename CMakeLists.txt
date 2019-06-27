cmake_minimum_required(VERSION 2.8.12)

find_package(ECM REQUIRED NO_MODULE)

set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR} ${CMAKE_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings NO_POLICY_SCOPE)
include(FeatureSummary)

find_library(NAMES aquila)

# Locate plasma_install_package macro.
find_package(KF5 REQUIRED COMPONENTS
	Plasma
)

find_package(Qt5 CONFIG REQUIRED COMPONENTS
    Quick
    Multimedia
    Core
)

add_subdirectory("src")

feature_summary(WHAT ALL FATAL_ON_MISSING_REQUIRED_PACKAGES)
