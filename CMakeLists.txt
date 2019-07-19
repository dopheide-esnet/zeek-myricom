cmake_minimum_required(VERSION 2.6.3)

project(BroPluginMyricom)
include(BroPlugin)
find_package(Myricom)

if ( MYRICOM_FOUND )
    include_directories(BEFORE ${MYRICOM_INCLUDE_DIR})
    zeek_plugin_begin(Bro Myricom)
    zeek_plugin_cc(src/Plugin.cc)
    zeek_plugin_cc(src/Myricom.cc)
    zeek_plugin_bif(src/myricom.bif)
    zeek_plugin_link_library(${MYRICOM_LIBRARY})
    zeek_plugin_dist_files(README CHANGES COPYING VERSION broctl/myricom.py)
    zeek_plugin_end()

    file(STRINGS "${CMAKE_CURRENT_SOURCE_DIR}/VERSION" VERSION LIMIT_COUNT 1)

    if ("${PROJECT_SOURCE_DIR}" STREQUAL "${CMAKE_SOURCE_DIR}")
        # Allows building rpm/deb packages via "make package" in build dir.
        include(ConfigurePackaging)
        ConfigurePackaging(${VERSION})
    endif ()

    message(STATUS "Myricom prefix      : ${MYRICOM_ROOT_DIR}")
else ()
    message(FATAL_ERROR "Myricom library and/or headers not found.")
endif ()
