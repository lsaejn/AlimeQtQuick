import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 1.1

Rectangle {
    id: bar
    MouseArea {
        id: moveBarArea
        anchors{
            top: parent.top
            right: minimalize.left
            left: parent.left
            bottom: parent.bottom
        }
        function maximalizeFunc(protect) {
            window.maximalized = !window.maximalized
            if(protect === true) {
                moveProtector.protect = true
                moveProtector.restart()
            }
            if(window.maximalized){
                 window.showMaximized()
            }
            else{
                 window.showNormal()
            }
        }

        Timer {
            id: moveProtector
            property bool protect: false
            property real len
            property int ycoord
            property point abs
            interval: 1; running: false; repeat: false
            onTriggered: {
                protect = false //normal protect
                if(len > 0) { //scale protect
                    var xcoord = Math.floor(abs.x - (moveBarArea.width*len))
                    startWindowPos = Qt.point(xcoord, ycoord)
                    startWindowSize = Qt.size(window.width, window.height)
                    startMousePos = abs
                    window.x = xcoord
                    window.y = ycoord
                }
                len = 0
            }
        }

        onDoubleClicked: maximalizeFunc(true)
        onPressed: {
            startMousePos = absoluteMousePos(this)
            startWindowPos = Qt.point(window.x, window.y)
            startWindowSize = Qt.size(window.width, window.height)
        }
        onMouseXChanged:{
            if(pressed && !window.maximalized && !moveProtector.protect) {
                var abs = absoluteMousePos(this)
                window.x = startWindowPos.x + (abs.x - startMousePos.x)
            }
        }
        onMouseYChanged: {
            if(pressed && !moveProtector.protect) {
                var abs = absoluteMousePos(this)
                window.y = Math.max(Screen.virtualY, startWindowPos.y + (abs.y - startMousePos.y))

                //if( window.y < Screen.virtualY + 1 && !window.maximalized )
               //   maximalizeFunc(true)
                if( window.y > Screen.virtualY && window.maximalized ) {
                    var xcoord = mouseX/moveBarArea.width;
                    maximalizeFunc(false)
                    moveProtector.len = xcoord
                    moveProtector.abs = abs
                    moveProtector.ycoord = abs.y - mouseY
                    moveProtector.protect = true
                    moveProtector.start()
                }
            }
        }
    }

    Rectangle {

    }

    Text {
            text: "你好吗你好吗你好吗"
            color: "white"
            font.family: "微软雅黑 Light"
            font.pixelSize: 14
            //elide: Text.ElideRight
            anchors.left:parent.left
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            //anchors.horizontalCenter: parent.horizontalCenter
            //anchors.centerIn: parent
    }

    Rectangle {
        id: close
        color: "transparent"
        width: 40
        anchors{
            right: parent.right
            top: parent.top
        }
        height: parent.height
        Rectangle {
            color: "white"
            rotation: -45
            transformOrigin: Item.Center
            anchors.centerIn: parent
            height: parent.height - 10
            width: 1
        }
        Rectangle {
            color: "white"
            rotation: 45
            transformOrigin: Item.Center
            anchors.centerIn: parent
            height: parent.height - 10
            width: 1
        }
        MouseArea {
           anchors.fill: parent
           hoverEnabled: true;
           onEntered: parent.color = "tomato"
           onExited: parent.color = "transparent"
           onClicked: Qt.quit()
           onPressed: parent.opacity = 0.6
           onReleased: parent.opacity = 1
        }
        Behavior on color {
            ColorAnimation { duration: 200 }
        }
        Behavior on opacity {
            OpacityAnimator { duration: 100 }
        }
    }

    Rectangle {
        id: maximalize;
        color: bar.color

        anchors{
            right: close.left
            top: parent.top
        }
        height: parent.height
        width: 40
        Rectangle {
            id: max;
            visible: !window.maximalized
            anchors {
                fill: parent
                margins: 10
            }
            color: "transparent"
            border{
                color: "white"
                width: 1
            }
        }

        Rectangle {
            id: min;
            visible: window.maximalized
            anchors {
                fill: maximalize
                leftMargin: 10
                rightMargin: 12
                topMargin: 12
                bottomMargin: 10
            }
            color: "transparent"
            border{
                color: "white"
                width: 1
            }
            Rectangle {
                visible: window.maximalized
                anchors {
                    top: parent.top
                    right: parent.right
                    topMargin: -3
                    rightMargin: -3
                }
                color: "white"
                height: 1
                width: parent.width
            }
            Rectangle {
                visible: window.maximalized
                anchors {
                    top: parent.top
                    right: parent.right
                    topMargin: -3
                    rightMargin: -3
                }
                color: "white"
                height: parent.height
                width: 1
            }
        }

        MouseArea {
           id: maximalizator
           anchors.fill: parent
           hoverEnabled: true;
           onEntered: maximalize.color = "skyblue"
           onExited: maximalize.color = bar.color
           onPressed: parent.opacity = 0.6
           onReleased: parent.opacity = 1
           onClicked: {
               window.maximalized = !window.maximalized
               if(window.maximalized){
                    window.showMaximized()
               }
               else{
                    window.showNormal()
               }
            }
        }
        Behavior on color {
            ColorAnimation { duration: 200 }
        }
        Behavior on opacity {
            OpacityAnimator { duration: 100 }
        }
    }

    //最小化
    Rectangle {
        id: minimalize
        color: "transparent"
        anchors{
            right: maximalize.left
            top: parent.top
        }
        height: parent.height
        width: 40
        Rectangle {
            anchors.centerIn: parent
            height: 2
            width: 20
            color: "white"
        }
        MouseArea {
           anchors.fill: parent
           hoverEnabled: true;
           onEntered: parent.color = "skyblue"
           onExited: parent.color = "transparent"
           onPressed: parent.opacity = 0.6
           onReleased: parent.opacity = 1
           onClicked: window.showMinimized()
        }
        Behavior on color {
            ColorAnimation { duration: 200 }
        }
        Behavior on opacity {
            OpacityAnimator { duration: 100 }
        }
    }
}
