import QtQuick 2.0

Rectangle {
    color: "#3C3C3C"

    function setDetails(index)
    {
        name.text = draftModel.get(index).name;
        team.text = draftModel.get(index).team;
        flag.source = draftModel.get(index).flag;
        photo.source = draftModel.get(index).photo;
    }

    // TODO> define listModel somewhere (C++)
    ListModel {
        id: draftModel
        ListElement {name: "Micheal"; team: "A-Tream"; photo: "resources/pic1.png"; flag: "resources/flag1.png"}
        ListElement {name: "Fabian"; team: "B-Tream"; photo: "resources/pic2.png"; flag: "resources/flag2.png"}
        ListElement {name: "Steve"; team: "C-Tream"; photo: "resources/pic3.png"; flag: "resources/flag3.png"}
        ListElement {name: "Marco"; team: "D-Tream"; photo: "resources/pic4.png"; flag: "resources/flag4.png"}
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
                text: model.name
            }
            MouseArea {
                anchors.fill: parent
                onClicked: setDetails(model.index)
            }
        }
    }

    Row {
        id: row
        height: 200
        anchors.top: parent.top
        anchors.left: parent.left

        Image {
            id: photo
            width: 200
            height: parent.height
        }
        anchors.margins: 5

        spacing: 5

        Column {
            spacing: 5
            Text { text: "Name"; color: "black"}
            Text { id: name; color: "white"}
            Text { text: "Team"; color: "black"}
            Text { id: team; color: "white"}
        }
    }


    Image {
        id: flag
        width: 100
        height: 80
        anchors {
            top: parent.top
            topMargin: 10
            left: row.right
            leftMargin: 50
        }
    }

    ShaderEffect {
        id: shaderEffect
        anchors.fill: flag
        anchors {
            left: parent.left
            top: parent.top
        }

        property variant source: flag
        property real frequency: 10
        property real amplitude: 0.04
        property real time

        NumberAnimation on time {
            from: 0; to: Math.PI * 2
            duration: 1500
            loops: Animation.Infinite
        }

        fragmentShader:
            "varying highp vec2 qt_TexCoord0;
            uniform sampler2D source;
            uniform lowp float qt_Opacity;
            uniform highp float frequency;
            uniform highp float amplitude;
            uniform highp float time;
            void main(){
                  vec2 p= sin(time + frequency * qt_TexCoord0);
                  gl_FragColor = texture2D(source, qt_TexCoord0 + amplitude *vec2(p.y, -p.x))* qt_Opacity;
                       }";
    }


    Text {
        anchors.centerIn: parent;
        text: "<Add More Contents Here...>"
        font.pointSize: 20
    }

    Component.onCompleted: setDetails(0);
}
