import QtQuick 2.0

Rectangle {
    id: root

    property int actionWidth: 50
    property int currentIndex: 0
    property string title: "HomePage"

    width: 800
    height: 500
    color: "#3C3C3C"

    function displayPage(index)
    {
        homePage.visible = false;
        mediaPage.visible = false;
        canvasPage.visible = false;
        webPage.visible = false;

        switch (index) {
        case 0:
            homePage.visible = true;
            root.title = "HomePage";
            break;
        case 1:
            mediaPage.visible = true;
            root.title = "VideoPage";
            break;
        case 2:
            canvasPage.visible = true;
            root.title = "CanvasPage";
            break;
        case 3:
            webPage.visible = true;
            root.title = "WebPage";
            break;
        default:
            break;
        }

    }

    Rectangle {
        id: header

        height: 50
        anchors.top: root.top
        anchors.left: root.left
        anchors.right: root.right
        color: "#5C5C5C"
        border.width: 2
        border.color: "black"


        Text {
            anchors.centerIn: parent
            text: root.title
        }
    }

    // TODO> Create Custom Page Component
    WelcomePage {
        id: homePage

        visible: true
        opacity: visible ? 1 : 0

        anchors {
            right: root.right
            left: root.left
            top: header.bottom
            bottom: footer.top
        }

        Behavior on opacity {
            NumberAnimation{ duration: 500 }
        }
    }

    MediaPage {
        id: mediaPage

        visible: false
        opacity: visible ? 1 : 0

        anchors {
            right: root.right
            left: root.left
            top: header.bottom
            bottom: footer.top
        }

        Behavior on opacity {
            NumberAnimation{ duration: 500 }
        }
    }

    CanvasPage {
        id: canvasPage

        visible: false
        opacity: visible ? 1 : 0

        anchors {
            right: root.right
            left: root.left
            top: header.bottom
            bottom: footer.top
        }

        Behavior on opacity {
            NumberAnimation{ duration: 500 }
        }
    }

    WebViewPage {
        id: webPage

        visible: false
        opacity: visible ? 1 : 0

        anchors {
            right: root.right
            left: root.left
            top: header.bottom
            bottom: footer.top
        }

        Behavior on opacity {
            NumberAnimation{ duration: 500 }
        }
    }


    Rectangle {
        id: footer

        height: 50
        color: "#5C5C5C"
        border.width: 2
        border.color: "black"

        anchors {
            right: root.right
            left: root.left
            bottom: root.bottom
        }

        Row {
            anchors.centerIn: parent

            Repeater {
                model: 4

                Rectangle {
                    color: "#2C2C2C"
                    height: footer.height
                    width: actionWidth
                    border.color: "black"

                    Image {
                        id: icon

                        width: parent.width/2
                        height: parent.height/2
                        source: "resources/icon_"+index+".png"
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: displayPage(model.index);

                    }
                }
            }
        }

    }

}
