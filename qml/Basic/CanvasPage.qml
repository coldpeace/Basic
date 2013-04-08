import QtQuick 2.0

Rectangle {
    color: "#3C3C3C"

    function modelSum() {
    var modelSum = 0;
    for (var index = 0; index < draftModel.count; index++)
            modelSum += draftModel.get(index).value

    return modelSum;
    }

    ListModel {
        id: draftModel
        ListElement { label:"Scientific Research";
            value:21; color:"#99e600" }
        ListElement { label:"Engineering & Design";
            value:18; color:"#99cc00" }
        ListElement { label:"Automotive";
            value:14; color:"#99b300" }
        ListElement { label:"Aerospace";
            value:13; color:"#9f991a" }
        ListElement { label:"Automation & Machine Tools";
            value:13; color:"#a48033" }
        ListElement { label:"Medical & Bioinformatics";
            value:13; color:"#a9664d" }
        ListElement { label:"Imaging & Special Effects";
            value:12; color:"#ae4d66" }
        ListElement { label:"Defense";
            value:11; color:"#b33380" }
        ListElement { label:"Test & Measurement Systems";
            value:9;  color:"#a64086" }
        ListElement { label:"Oil & Gas";
            value:9;  color:"#994d8d" }
        ListElement { label:"Entertainment & Broadcasting";
            value:7;  color:"#8d5a93" }
        ListElement { label:"Financial";
            value:6;  color:"#806699" }
        ListElement { label:"Consumer Electronics";
            value:4;  color:"#8073a6" }
        ListElement { label:"Other";
            value:38; color:"#8080b3" }
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
            color: model.color
            Text {
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                text: model.label
            }

            Text {
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                text: model.value
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


    Canvas {
        id: canvas
        anchors.left: parent.left
        anchors.right: listView.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        onPaint: {
            // get the drawing context
            var ctx = canvas.getContext('2d')

            ctx.clearRect(0, 0, width, height)
            // store the circles properties
            var centerX = width / 2

            var centerY = height / 2
            var radius = 0.9 * Math.min(width, height) / 2
            var startAngle = 0.0
            var endAngle = 0.0
            // calculate the factor that scales the angles // to make the sectors sum up to a full circle
            var angleFactor = 2 * Math.PI / modelSum()
            ctx.lineWidth = 2
            ctx.strokeStyle = Qt.lighter(root.color)
            // iterate over the model’s elements
            for (var index = 0; index < draftModel.count; index++) {
                // calculate the start and end angles
                startAngle = endAngle
                endAngle = startAngle + draftModel.get(index).value * angleFactor
                ctx.fillStyle = draftModel.get(index).color
                // draw the piece
                ctx.beginPath()
                ctx.moveTo(centerX, centerY)
                ctx.arc(centerX, centerY, radius, startAngle, endAngle, false)
                ctx.lineTo(centerX, centerY)
                ctx.fill()
                ctx.stroke()
            }

        }
    }
}
