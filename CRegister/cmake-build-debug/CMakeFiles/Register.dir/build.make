# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.15

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
CMAKE_COMMAND = /Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake

# The command to remove a file.
RM = /Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/djx/CLionProjects/Register

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/djx/CLionProjects/Register/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/Register.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/Register.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/Register.dir/flags.make

CMakeFiles/Register.dir/library.cpp.o: CMakeFiles/Register.dir/flags.make
CMakeFiles/Register.dir/library.cpp.o: ../library.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/djx/CLionProjects/Register/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/Register.dir/library.cpp.o"
	/Library/Developer/CommandLineTools/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/Register.dir/library.cpp.o -c /Users/djx/CLionProjects/Register/library.cpp

CMakeFiles/Register.dir/library.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/Register.dir/library.cpp.i"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/djx/CLionProjects/Register/library.cpp > CMakeFiles/Register.dir/library.cpp.i

CMakeFiles/Register.dir/library.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/Register.dir/library.cpp.s"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/djx/CLionProjects/Register/library.cpp -o CMakeFiles/Register.dir/library.cpp.s

CMakeFiles/Register.dir/clz_Register.c.o: CMakeFiles/Register.dir/flags.make
CMakeFiles/Register.dir/clz_Register.c.o: ../clz_Register.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/djx/CLionProjects/Register/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/Register.dir/clz_Register.c.o"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/Register.dir/clz_Register.c.o   -c /Users/djx/CLionProjects/Register/clz_Register.c

CMakeFiles/Register.dir/clz_Register.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/Register.dir/clz_Register.c.i"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/djx/CLionProjects/Register/clz_Register.c > CMakeFiles/Register.dir/clz_Register.c.i

CMakeFiles/Register.dir/clz_Register.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/Register.dir/clz_Register.c.s"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/djx/CLionProjects/Register/clz_Register.c -o CMakeFiles/Register.dir/clz_Register.c.s

CMakeFiles/Register.dir/DynamicRegister.c.o: CMakeFiles/Register.dir/flags.make
CMakeFiles/Register.dir/DynamicRegister.c.o: ../DynamicRegister.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/djx/CLionProjects/Register/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object CMakeFiles/Register.dir/DynamicRegister.c.o"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/Register.dir/DynamicRegister.c.o   -c /Users/djx/CLionProjects/Register/DynamicRegister.c

CMakeFiles/Register.dir/DynamicRegister.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/Register.dir/DynamicRegister.c.i"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/djx/CLionProjects/Register/DynamicRegister.c > CMakeFiles/Register.dir/DynamicRegister.c.i

CMakeFiles/Register.dir/DynamicRegister.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/Register.dir/DynamicRegister.c.s"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/djx/CLionProjects/Register/DynamicRegister.c -o CMakeFiles/Register.dir/DynamicRegister.c.s

# Object files for target Register
Register_OBJECTS = \
"CMakeFiles/Register.dir/library.cpp.o" \
"CMakeFiles/Register.dir/clz_Register.c.o" \
"CMakeFiles/Register.dir/DynamicRegister.c.o"

# External object files for target Register
Register_EXTERNAL_OBJECTS =

libRegister.dylib: CMakeFiles/Register.dir/library.cpp.o
libRegister.dylib: CMakeFiles/Register.dir/clz_Register.c.o
libRegister.dylib: CMakeFiles/Register.dir/DynamicRegister.c.o
libRegister.dylib: CMakeFiles/Register.dir/build.make
libRegister.dylib: CMakeFiles/Register.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/djx/CLionProjects/Register/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CXX shared library libRegister.dylib"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/Register.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/Register.dir/build: libRegister.dylib

.PHONY : CMakeFiles/Register.dir/build

CMakeFiles/Register.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/Register.dir/cmake_clean.cmake
.PHONY : CMakeFiles/Register.dir/clean

CMakeFiles/Register.dir/depend:
	cd /Users/djx/CLionProjects/Register/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/djx/CLionProjects/Register /Users/djx/CLionProjects/Register /Users/djx/CLionProjects/Register/cmake-build-debug /Users/djx/CLionProjects/Register/cmake-build-debug /Users/djx/CLionProjects/Register/cmake-build-debug/CMakeFiles/Register.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/Register.dir/depend

