# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.14

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/parker/Documents/playground/media_control

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/parker/Documents/playground/media_control/build

# Utility rule file for org.mediacontrol-plasmoids-metadata-json.

# Include the progress variables for this target.
include CMakeFiles/org.mediacontrol-plasmoids-metadata-json.dir/progress.make

CMakeFiles/org.mediacontrol-plasmoids-metadata-json: org.mediacontrol-plasmoids-metadata.json


org.mediacontrol-plasmoids-metadata.json: ../plasmoid/metadata.desktop
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/parker/Documents/playground/media_control/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating org.mediacontrol-plasmoids-metadata.json"
	/usr/bin/desktoptojson -i /home/parker/Documents/playground/media_control/plasmoid/metadata.desktop -o /home/parker/Documents/playground/media_control/build/org.mediacontrol-plasmoids-metadata.json

org.mediacontrol-plasmoids-metadata-json: CMakeFiles/org.mediacontrol-plasmoids-metadata-json
org.mediacontrol-plasmoids-metadata-json: org.mediacontrol-plasmoids-metadata.json
org.mediacontrol-plasmoids-metadata-json: CMakeFiles/org.mediacontrol-plasmoids-metadata-json.dir/build.make

.PHONY : org.mediacontrol-plasmoids-metadata-json

# Rule to build all files generated by this target.
CMakeFiles/org.mediacontrol-plasmoids-metadata-json.dir/build: org.mediacontrol-plasmoids-metadata-json

.PHONY : CMakeFiles/org.mediacontrol-plasmoids-metadata-json.dir/build

CMakeFiles/org.mediacontrol-plasmoids-metadata-json.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/org.mediacontrol-plasmoids-metadata-json.dir/cmake_clean.cmake
.PHONY : CMakeFiles/org.mediacontrol-plasmoids-metadata-json.dir/clean

CMakeFiles/org.mediacontrol-plasmoids-metadata-json.dir/depend:
	cd /home/parker/Documents/playground/media_control/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/parker/Documents/playground/media_control /home/parker/Documents/playground/media_control /home/parker/Documents/playground/media_control/build /home/parker/Documents/playground/media_control/build /home/parker/Documents/playground/media_control/build/CMakeFiles/org.mediacontrol-plasmoids-metadata-json.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/org.mediacontrol-plasmoids-metadata-json.dir/depend
