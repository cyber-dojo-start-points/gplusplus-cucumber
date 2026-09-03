# Each source is compiled on its own and the objects are linked, rather than
# handing the compiler both at once, so the step definitions and the code they
# exercise compile at the same time as each other. The step definitions carry
# nearly all of the cost here: they include cucumber-cpp's headers and GoogleTest's,
# where hiker.cpp includes neither.
MAKEFLAGS += --jobs

CXXFLAGS += -I.
CXXFLAGS += -std=c++2a
CXXFLAGS += -Wall -Wextra
# Not optimised. The step definitions run for a few milliseconds under cucumber,
# so nothing here is waiting on how fast the code runs, and optimising it costs
# more time in the compiler than it ever gives back.
CXXFLAGS += -O0
# No coverage instrumentation. cyber-dojo.sh here runs cucumber and nothing
# else; there is no gcovr step to read a coverage report, so instrumenting the
# build only slowed it down to produce counts nobody ever saw.

# The image holds precompiled GoogleTest and cucumber-cpp headers, and reading
# them back is a great deal quicker than parsing them again on every
# [test] press. gcc only uses a precompiled header when it comes before
# everything else in the file, which is what -include does here without your
# step definitions having to say so.
#
# These flags have to match the ones the image precompiled with. Change any of
# the above and gcc quietly ignores the precompiled header: nothing breaks, the
# run is just back to its old speed.
CXXFLAGS += -include cucumber_cpp_gtest_pch.hpp

GTEST_LIBS = -lgtest -pthread
BOOST_LIBS = -lboost_thread -lboost_system -lboost_regex -lboost_date_time -lboost_program_options -lboost_filesystem
CUCUMBER_LIB = -lcucumber-cpp

HPP_FILES = $(wildcard *.hpp)
COMPILED_HPP_FILES = $(patsubst %.hpp,%.compiled_hpp,$(HPP_FILES))
CPP_FILES = $(wildcard *.cpp)
CPP_STEP_FILES = $(wildcard features/step_definitions/*.cpp)
OBJ_FILES = $(patsubst %.cpp,%.o,$(CPP_FILES) $(CPP_STEP_FILES))

.PHONY: test.output
test.output: test makefile
	@./$< > /dev/null &

test: $(OBJ_FILES) $(COMPILED_HPP_FILES)
	@$(CXX) $(CXXFLAGS) $(OBJ_FILES) $(GTEST_LIBS) $(BOOST_LIBS) $(CUCUMBER_LIB) -o $@

%.o: %.cpp
	@$(CXX) $(CXXFLAGS) -c $< -o $@

# This rule ensures header files build in their own right.
# The quality of header files is important because header files
# are #included from other files and thus have a large span
# of influence (unlike .cpp files which are not #included)

%.compiled_hpp: %.hpp
	@$(CXX) -x c++ $(CXXFLAGS) -c -o $@ $<
