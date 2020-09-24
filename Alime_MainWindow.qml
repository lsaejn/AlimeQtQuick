import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Window 2.14

Window{
    id: window
    visible: true
    width: 1024
    height: 768
    color: "#202020"
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowMinimizeButtonHint | Qt.WindowMaximizeButtonHint
    minimumWidth: 400
    minimumHeight: 200
    // for window movement
    property bool maximalized: false
    property point startMousePos
    property point startWindowPos
    property size startWindowSize

    function absoluteMousePos(mouseArea) {
        var windowAbs = mouseArea.mapToItem(null, mouseArea.mouseX, mouseArea.mouseY)
        return Qt.point(windowAbs.x + window.x,
                        windowAbs.y + window.y)
    }

    Alime_TitleBar {
        id: topBar
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
        }

        height: 40
        color: "black"
        smooth: true
    }

    Item {
        anchors{
            top: topBar.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        /*Your content here*/
    }

    Alime_WindowBase {
        anchors.fill: parent
        size: 3
    }
}

/*##^##
Designer {
    D{i:0;3d-active-scene:-1}
}
##^##*/
