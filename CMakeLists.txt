cmake_minimum_required(VERSION 3.12)
project(MySaw)
set(project_name "MySaw")

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_SHARED_MODULE_PREFIX "")

include_directories(${CMAKE_CURRENT_LIST_DIR}/my_saw)
include_directories(${CMAKE_CURRENT_LIST_DIR}/include/plugin_interface)
include_directories(${CMAKE_CURRENT_LIST_DIR}/include/common)

add_library(MySaw MODULE
    ${CMAKE_CURRENT_LIST_DIR}/src/my_saw/MySaw.cpp
)
