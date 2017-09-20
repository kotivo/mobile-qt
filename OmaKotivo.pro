QT += qml quick network
CONFIG += c++11
SOURCES += main.cpp
RESOURCES += qml.qrc
DEFINES += QT_DEPRECATED_WARNINGS

QML_IMPORT_PATH =
QML_DESIGNER_IMPORT_PATH =

qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

android {
    ANDROID_EXTRA_LIBS = $$PWD/android/lib/libcrypto.so $$PWD/android/lib/libssl.so
}
