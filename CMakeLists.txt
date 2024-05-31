cmake_minimum_required(VERSION 3.16)

project(18-BackendFinal VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED Widgets Network)

qt_add_executable(app18-BackendFinal
    main.cpp
)

qt_add_qml_module(app18-BackendFinal
    URI 18-BackendFinal
    VERSION 1.0
    QML_FILES main.qml
    SOURCES TCPPackets.h TCPPackets.cpp
    SOURCES Conversion.h Conversion.cpp
    SOURCES DataModel.h DataModel.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(app18-BackendFinal PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.app18-BackendFinal
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(app18-BackendFinal
    PRIVATE Qt6::Quick Qt6::Widgets Qt6::Network)

include(GNUInstallDirs)
install(TARGETS app18-BackendFinal
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
