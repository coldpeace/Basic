import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
    color: "#3C3C3C"

    ListModel {
        id: draftModel
        ListElement{url:"resources/garden.mp4"}
        ListElement{url:"resources/anim_layer_interface.mp4"}
        ListElement{url:"resources/garden.mp4"}
        ListElement{url:"resources/anim_layer_interface.mp4"}
    }

    ListView {
        id: listView

        width: 200
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        model: draftModel
        // TODO> define custome delegate as component
        delegate: Rectangle {
            height: 50
            anchors.right: parent.right
            anchors.left: parent.left
            border.width: 1
            border.color: "black"
            Text {
                anchors.centerIn: parent
                text: model.url
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    video.source = model.url
                    video.play();
                }
            }
        }
    }

    Rectangle {
        id: container

        color: "black"
        anchors.left: parent.left
        anchors.right: listView.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        Text {
            anchors.centerIn: parent
            text: "select video from the list to play...";
            color: "white"
        }

    }

    Video {
        id: video
        anchors.fill: container
    }
    // TODO> Add playback controls (play, pause, stop, ...)
}
