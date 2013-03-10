# -------------------------------------------------
# Project created by QtCreator 2011-11-19T08:29:49
# -------------------------------------------------
#
# Windows builds must use library 4.8.0 otherwise QuaZip fails.
# Same goes for QuaZip build.
#
QT += core \
    gui
TARGET = SimpleIDE
TEMPLATE = app
DEFINES += QEXTSERIALPORT_LIB
DEFINES += SPINSIDE

#include quazip
INCLUDEPATH += ../quazip-0.5/quazip
INCLUDEPATH += $$[QT_INSTALL_PREFIX]/src/3rdparty/zlib

# Turn off SPIN features for EDU release
# DEFINES += SPIN_AUTOCOMPLETE
DEFINES += SPIN

# IDEDEBUG define sends qDebug() output to a Debug TAB.
# This is most useful with windows as console output is not available there.
# DEFINES += IDEDEBUG
# EVENT_DRIVEN QEXTSERIALPORT is no longer used.
# GDBENABLE is not ready, and will only be used for development testing
# DEFINES += GDBENABLE
# These define the version number in Menu->About
DEFINES += IDEVERSION=0
DEFINES += MINVERSION=9
DEFINES += FIXVERSION=15
SOURCES += mainspin.cpp \
    editor.cpp \
    ctags.cpp \
    mainspinwindow.cpp \
    cbuildtree.cpp \
    treemodel.cpp \
    treeitem.cpp \
    projecttree.cpp \
    terminal.cpp \
    termprefs.cpp \
    properties.cpp \
    newproject.cpp \
    PortListener.cpp \
    highlighter.cpp \
    hardware.cpp \
    help.cpp \
    console.cpp \
    asideconfig.cpp \
    asideboard.cpp \
    projectoptions.cpp \
    replacedialog.cpp \
    aboutdialog.cpp \
    loader.cpp \
    qextserialport.cpp \
    qextserialenumerator.cpp \
    buildc.cpp \
    buildspin.cpp \
    build.cpp \
    spinhighlighter.cpp \
    spinparser.cpp \
    gdb.cpp \
    highlightc.cpp \
    hintdialog.cpp \
    blinker.cpp \
    buildstatus.cpp \
    highlightbuild.cpp
HEADERS += mainspinwindow.h \
    editor.h \
    ctags.h \
    highlighter.h \
    treemodel.h \
    treeitem.h \
    PortListener.h \
    terminal.h \
    termprefs.h \
    properties.h \
    newproject.h \
    console.h \
    hardware.h \
    help.h \
    asideboard.h \
    asideconfig.h \
    cbuildtree.h \
    projectoptions.h \
    Sleeper.h \
    replacedialog.h \
    aboutdialog.h \
    loader.h \
    projecttree.h \
    qextserialport.h \
    qextserialenumerator.h \
    buildc.h \
    buildspin.h \
    build.h \
    spinhighlighter.h \
    spinparser.h \
    gdb.h \
    highlightc.h \
    propertycolor.h \
    qportcombobox.h \
    hintdialog.h \
    blinker.h \
    buildstatus.h \
    highlightbuild.h
FORMS += hardware.ui \
    project.ui \
    TermPrefs.ui \
    hintdialog.ui
RESOURCES += resources.qrc
# linux quazip doesn't need version, but windows does
unix {
    SOURCES += qextserialport_unix.cpp
    LIBS += -lquazip
}
# dont use EVENT_DRIVEN for linux to be consistent with MAC.
unix:!macx:SOURCES += qextserialenumerator_unix.cpp
macx { 
    # dont use EVENT_DRIVEN for mac. must open terminal before load because mac would reset boards otherwise.
    SOURCES += qextserialenumerator_osx.cpp
    LIBS += -framework \
        IOKit \
        -framework \
        CoreFoundation
}
win32 { 
    RC_FILE = myapp.rc
    
    # don't use EVENT_DRIVEN for windows. causes crashes.
    SOURCES += qextserialport_win.cpp
    SOURCES += qextserialenumerator_win.cpp
    DEFINES += WINVER=0x0501 # needed for mingw to pull in appropriate dbt business...probably a better way to do this
    LIBS += -lsetupapi
    LIBS += -lquazip1
}

