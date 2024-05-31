import QtQuick
import QtQuick.Controls.Windows
import QtQuick.Controls
import QtCharts
import QtQuick.Layouts
import DataModel

Window {
    id: root
    minimumHeight: 480
    minimumWidth: 640
    visibility: Window.Maximized
    visible: true
    title: qsTr("Hello World")
    property double varStartFrequency: 174
    property double varStopFrequency: 226
    DataModel {
        id: myModel
    }
    Timer {
        id: timer
        interval: 1000
        repeat: false
    }

    Rectangle {
        id: mainCanvas
        anchors.fill: parent
        anchors.margins: 10
        color: "green"
        ColumnLayout {
            id: colLayout
            anchors.fill: parent
            spacing: 0
            Rectangle {
                id: row1
                color: "red"
                Layout.minimumHeight: 355
                Layout.fillWidth: true
                Layout.fillHeight: true
                RowLayout {
                    id: rowLayout1
                    spacing: 0
                    anchors.fill: parent
                    Rectangle {
                        id: holderY
                        Layout.minimumWidth: 130
                        Layout.maximumWidth: 130
                        Layout.fillHeight: true
                        //color: "orange"
                        ColumnLayout {
                            id: colLayoutY
                            anchors.fill: parent
                            spacing: 0

                            Rectangle {
                                id: holderMaxY
                                Layout.minimumHeight: 49
                                Layout.maximumHeight: 49
                                Layout.minimumWidth: 130
                                Layout.maximumWidth: 130
                                color: "#0000ff38"
                                TextField {
                                    id: yMax
                                    x: 0
                                    width: 70
                                    text: axisY.max
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    anchors.left: parent.left
                                    anchors.topMargin: 5
                                    anchors.bottomMargin: 5
                                    anchors.leftMargin: 10
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 15
                                    font.family: "Verdana"
                                    placeholderText: qsTr("")
                                    background: Rectangle {
                                        implicitWidth: 200
                                        implicitHeight: 40
                                        border.color: "black"
                                        radius: 10
                                        color: yMax.enabled ? "transparent" : "#353637"
                                        //border.color: control.enabled ? "#21be2b" : "transparent"
                                    }
                                    validator: DoubleValidator {
                                        top: 130
                                        bottom: -230
                                    }
                                    maximumLength: 4
                                    onTextEdited: {
                                        if (yMax.text < -230
                                                || yMax.text > 130) {
                                            yMax.color = "red"
                                        } else {
                                            yMax.color = "black"
                                            axisY.max = yMax.text
                                        }
                                    }
                                }
                                Label {
                                    x: 61
                                    y: 15
                                    text: qsTr("dBm")
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.right: parent.right
                                    anchors.rightMargin: 0
                                    font.pointSize: 12
                                    font.family: "Verdana"
                                }
                            }
                            Rectangle {
                                id: holderdBdiv
                                Layout.minimumHeight: 100
                                Layout.maximumHeight: 100
                                Layout.minimumWidth: 130
                                Layout.maximumWidth: 130
                                Label {
                                    id: labeldBdiv
                                    text: qsTr("dB/div:")
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.leftMargin: 10
                                    anchors.topMargin: 20
                                    font.bold: false
                                    font.pointSize: 12
                                    font.family: "Verdana"
                                }

                                Rectangle {
                                    y: 40
                                    width: 125
                                    height: 50
                                    color: "#0000ff38"
                                    anchors.left: parent.left
                                    anchors.bottom: parent.bottom
                                    anchors.leftMargin: 5
                                    anchors.bottomMargin: 10
                                    TextField {
                                        id: dBdiv
                                        x: 0
                                        width: 70
                                        text: "10"
                                        anchors.top: parent.top
                                        anchors.bottom: parent.bottom
                                        anchors.left: parent.left
                                        anchors.topMargin: 5
                                        anchors.bottomMargin: 5
                                        anchors.leftMargin: 5
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        font.pointSize: 15
                                        font.family: "Verdana"
                                        placeholderText: qsTr("")

                                        background: Rectangle {
                                            implicitWidth: 200
                                            implicitHeight: 40
                                            border.color: "black"
                                            radius: 10
                                            color: dBdiv.enabled ? "transparent" : "#353637"
                                            //border.color: control.enabled ? "#21be2b" : "transparent"
                                        }
                                        validator: DoubleValidator {
                                            top: 20
                                            bottom: 0.01
                                        }
                                        maximumLength: 4
                                        onTextEdited: {
                                            if (dBdiv.text > 20
                                                    || dBdiv.text < 0.01) {
                                                dBdiv.color = "red"
                                            } else {
                                                dBdiv.color = "black"
                                                axisY.min = yMax.text - (yMax.text * dBdiv.text)
                                            }
                                        }
                                    }
                                    Label {
                                        id: labeldB
                                        x: 61
                                        y: 15
                                        text: qsTr("dB")
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.right: parent.right
                                        anchors.rightMargin: 10
                                        font.pointSize: 12
                                        font.family: "Verdana"
                                    }
                                }
                            }
                            Rectangle {
                                id: holderRefLevel
                                Layout.minimumHeight: 100
                                Layout.maximumHeight: 100
                                Layout.minimumWidth: 130
                                Layout.maximumWidth: 130
                                Label {
                                    id: labelRefLevel
                                    text: qsTr("Ref. Level:")
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.leftMargin: 10
                                    anchors.topMargin: 20
                                    font.pointSize: 12
                                    font.family: "Verdana"
                                    font.bold: false
                                }

                                Rectangle {
                                    y: 40
                                    width: 125
                                    height: 50
                                    color: "#0000ff38"
                                    anchors.left: parent.left
                                    anchors.bottom: parent.bottom
                                    anchors.leftMargin: 5
                                    anchors.bottomMargin: 10
                                    TextField {
                                        id: refLevel
                                        x: 0
                                        width: 70
                                        anchors.left: parent.left
                                        anchors.top: parent.top
                                        anchors.bottom: parent.bottom
                                        anchors.leftMargin: 5
                                        anchors.topMargin: 5
                                        anchors.bottomMargin: 5
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        placeholderText: qsTr("")
                                        font.pointSize: 15
                                        font.family: "Verdana"
                                        background: Rectangle {
                                            color: refLevel.enabled ? "transparent" : "#353637"
                                            radius: 10
                                            border.color: "#000000"
                                            implicitWidth: 200
                                            implicitHeight: 40
                                        }
                                    }

                                    Label {
                                        id: labeldB1
                                        x: 61
                                        y: 15
                                        text: qsTr("dBm")
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.right: parent.right
                                        anchors.rightMargin: 0
                                        font.pointSize: 12
                                        font.family: "Verdana"
                                    }
                                }
                            }

                            Rectangle {
                                Layout.minimumHeight: 1
                                Layout.maximumHeight: 1
                                Layout.minimumWidth: 130
                                Layout.maximumWidth: 130
                                color: "grey"
                            }

                            Rectangle {
                                id: holderButtonRun
                                Layout.minimumHeight: 52.5
                                Layout.maximumHeight: 52.5
                                Layout.minimumWidth: 130
                                Layout.maximumWidth: 130
                                Button {
                                    id: buttonRun
                                    text: qsTr("Start")
                                    font.pointSize: 12
                                    font.family: "Verdana"
                                    anchors.bottom: parent.bottom
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.leftMargin: 15
                                    anchors.rightMargin: 15
                                    contentItem: Text {
                                        text: buttonRun.text
                                        font: buttonRun.font
                                        opacity: enabled ? 1.0 : 0.3
                                        color: buttonRun.down ? "grey" : "white"
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        //elide: Text.ElideRight
                                    }

                                    background: Rectangle {
                                        implicitWidth: 100
                                        implicitHeight: 35
                                        color: "black"
                                        opacity: enabled ? 1 : 0.3
                                        border.color: buttonRun.down ? "black" : "black"
                                        border.width: 1
                                        radius: 10
                                    }
                                    onClicked: {
                                        if (buttonRun.text === "Start") {
                                            buttonRun.text = "Stop"
                                            labelStartStop.text = "Running"
                                            timer.running = true
                                        } else {
                                            buttonRun.text = "Start"
                                            labelStartStop.text = "Stopped"
                                            timer.stop()
                                        }
                                    }
                                }
                            }
                            Rectangle {
                                id: holderButtonAutoScale
                                Layout.minimumHeight: 52.5
                                Layout.maximumHeight: 52.5
                                Layout.minimumWidth: 130
                                Layout.maximumWidth: 130
                                Button {
                                    id: buttonAutoScale
                                    text: qsTr("AutoScale")
                                    font.pointSize: 12
                                    font.family: "Verdana"
                                    anchors.bottom: parent.bottom
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.leftMargin: 15
                                    anchors.rightMargin: 15
                                    contentItem: Text {
                                        text: buttonAutoScale.text
                                        font: buttonAutoScale.font
                                        opacity: enabled ? 1.0 : 0.3
                                        color: buttonAutoScale.down ? "grey" : "white"
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        elide: Text.ElideRight
                                    }

                                    background: Rectangle {
                                        implicitWidth: 100
                                        implicitHeight: 35
                                        color: "black"
                                        opacity: enabled ? 1 : 0.3
                                        border.color: buttonAutoScale.down ? "black" : "black"
                                        border.width: 1
                                        radius: 10
                                    }
                                    onClicked: {
                                        axisX.min = myModel.MinFreq
                                        axisX.max = myModel.MaxFreq
                                        axisY.min = myModel.MinAmp
                                        axisY.max = myModel.MaxAmp
                                    }
                                }
                            }
                            Rectangle {
                                Layout.minimumHeight: 15
                                Layout.maximumHeight: 15
                                Layout.minimumWidth: 130
                                Layout.maximumWidth: 130
                            }
                            Rectangle {
                                Layout.minimumHeight: 1
                                Layout.maximumHeight: 1
                                Layout.minimumWidth: 130
                                Layout.maximumWidth: 130
                                color: "grey"
                            }
                            Rectangle {
                                Layout.fillHeight: true
                                Layout.minimumWidth: 114
                                Layout.maximumWidth: 114
                                //color: "black"
                            }
                            Rectangle {
                                Layout.minimumHeight: 1
                                Layout.maximumHeight: 1
                                Layout.minimumWidth: 130
                                Layout.maximumWidth: 130
                                color: "grey"
                            }
                        }
                    }
                    Rectangle {
                        id: holderChart
                        Layout.minimumWidth: 490
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        //color: "teal"
                        ChartView {
                            id: chartView
                            anchors.fill: parent
                            legend.visible: false
                            plotAreaColor: "black"

                            //animationOptions: ChartView.SeriesAnimations
                            //animationDuration: 10000
                            LineSeries {
                                //name: "LineSeries"
                                id: lineSeries
                                color: "yellow"
                                width: 2
                                axisX: ValuesAxis {
                                    id: axisX
                                    min: varStartFrequency
                                    max: varStopFrequency
                                    tickCount: 10
                                }
                                axisY: ValuesAxis {
                                    id: axisY
                                    min: yMax.text - (yMax.text * dBdiv.text)
                                    max: 10
                                    tickCount: 10
                                }
                                VXYModelMapper {
                                    id: vxy
                                    xColumn: 0
                                    yColumn: 1
                                    firstRow: 0
                                    series: lineSeries
                                    model: myModel
                                }
                            }
                        }
                    }
                }
            }
            Rectangle {
                id: row2
                color: "pink"
                Layout.minimumHeight: 70
                Layout.maximumHeight: 70
                Layout.fillWidth: true
                RowLayout {
                    id: rowLayout2
                    spacing: 0
                    anchors.fill: parent
                    Rectangle {
                        id: holderSpectrum
                        Layout.minimumHeight: 70
                        Layout.maximumHeight: 70
                        Layout.minimumWidth: 130
                        Layout.maximumWidth: 130
                        Label {
                            id: labelSpectrum
                            anchors.centerIn: parent
                            text: qsTr("Spectrum:")
                            font.pointSize: 14
                            font.family: "Verdana"
                        }
                    }
                    Rectangle {
                        Layout.minimumHeight: 70
                        Layout.maximumHeight: 70
                        Layout.minimumWidth: 60
                        Layout.maximumWidth: 60
                        color: "white"
                    }

                    Rectangle {
                        id: holderStartFrequency
                        Layout.minimumHeight: 70
                        Layout.maximumHeight: 70
                        Layout.minimumWidth: 180
                        Layout.maximumWidth: 180
                        Label {
                            id: labelStartFrequency
                            x: -56
                            y: -188
                            text: qsTr("Start:")
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: 12
                            font.family: "Verdana"
                            font.bold: false
                        }

                        Rectangle {
                            x: -61
                            y: -168
                            width: 125
                            height: 50
                            color: "#0000ff38"
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            anchors.rightMargin: 0
                            anchors.bottomMargin: 10
                            TextField {
                                id: startFrequency
                                x: 0
                                width: 80
                                text: varStartFrequency
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.leftMargin: 5
                                anchors.topMargin: 5
                                anchors.bottomMargin: 5
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                placeholderText: qsTr("")
                                font.pointSize: 15
                                font.family: "Verdana"
                                maximumLength: 5
                                validator: DoubleValidator {
                                    bottom: 174
                                    top: 226
                                }
                                background: Rectangle {
                                    color: control.enabled ? "transparent" : "#353637"
                                    radius: 10
                                    border.color: "#000000"
                                    implicitWidth: 200
                                    implicitHeight: 40
                                }
                                onTextEdited: {
                                    if (startFrequency.text < 170
                                            || startFrequency.text > 230) {
                                        startFrequency.color = "red"
                                    } else {
                                        startFrequency.color = "Black"
                                        varStartFrequency = parseFloat(
                                                    startFrequency.text).toFixed(
                                                    2)
                                        axisX.min = varStartFrequency
                                    }
                                }
                            }

                            Label {
                                id: labelMHz
                                x: 61
                                y: 15
                                text: qsTr("MHz")
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 0
                                font.pointSize: 12
                                font.family: "Verdana"
                            }
                        }
                    }
                    Rectangle {
                        Layout.minimumHeight: 70
                        Layout.maximumHeight: 70
                        Layout.minimumWidth: 40
                        Layout.fillWidth: true
                    }
                    Rectangle {
                        id: holderStopFrequency
                        Layout.minimumHeight: 70
                        Layout.maximumHeight: 70
                        Layout.minimumWidth: 180
                        Layout.maximumWidth: 180
                        Label {
                            id: labelStopFrequency
                            x: -56
                            y: -188
                            text: qsTr("Stop:")
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: 12
                            font.family: "Verdana"
                            font.bold: false
                        }

                        Rectangle {
                            x: -61
                            y: -168
                            width: 125
                            height: 50
                            color: "#0000ff38"
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            anchors.rightMargin: 10
                            anchors.bottomMargin: 10
                            TextField {
                                id: stopFrequency
                                x: 0
                                width: 80
                                text: varStopFrequency
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.leftMargin: 5
                                anchors.topMargin: 5
                                anchors.bottomMargin: 5
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                placeholderText: qsTr("")
                                font.pointSize: 15
                                font.family: "Verdana"
                                maximumLength: 5
                                validator: DoubleValidator {
                                    bottom: 174
                                    top: 226
                                }
                                background: Rectangle {
                                    color: control.enabled ? "transparent" : "#353637"
                                    radius: 10
                                    border.color: "#000000"
                                    implicitWidth: 200
                                    implicitHeight: 40
                                }
                                onTextEdited: {
                                    if (stopFrequency.text < 170
                                            || stopFrequency.text > 230) {
                                        stopFrequency.color = "red"
                                    } else {
                                        stopFrequency.color = "Black"
                                        varStopFrequency = parseFloat(
                                                    stopFrequency.text).toFixed(
                                                    2)
                                        axisX.max = varStopFrequency
                                    }
                                }
                            }

                            Label {
                                id: labelMHz1
                                x: 61
                                y: 15
                                text: qsTr("MHz")
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 0
                                font.pointSize: 12
                                font.family: "Verdana"
                            }
                        }
                    }
                    Rectangle {
                        Layout.minimumHeight: 70
                        Layout.maximumHeight: 70
                        Layout.minimumWidth: 30
                        Layout.maximumWidth: 30
                        color: "white"
                    }
                }
            }
            Rectangle {
                height: 1
                Layout.minimumWidth: 620
                Layout.fillWidth: true
                color: "grey"
            }
            Rectangle {
                id: row3
                color: "blue"
                Layout.minimumHeight: 33
                Layout.maximumHeight: 33
                Layout.fillWidth: true
                RowLayout {
                    id: rowLayout3
                    spacing: 0
                    anchors.fill: parent
                    Rectangle {
                        id: holderStartStop
                        Layout.minimumHeight: 35
                        Layout.maximumHeight: 35
                        Layout.minimumWidth: 90
                        Layout.fillWidth: true

                        Label {
                            id: labelStartStop
                            text: qsTr("Stopped")
                            anchors.verticalCenter: parent.verticalCenter
                            font.pointSize: 12
                            font.family: "Verdana"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                    Rectangle {
                        height: 35
                        width: 1
                        color: "grey"
                    }

                    Rectangle {
                        id: holderMaxAmplitude
                        Layout.minimumHeight: 35
                        Layout.maximumHeight: 35
                        Layout.minimumWidth: 155
                        Layout.fillWidth: true
                        Label {
                            id: labelMaxAmplitude
                            //text: qsTr("Max. Amp: 121dB")
                            text: "Max. Amp: " + myModel.MaxAmp.toFixed(
                                      2) + " dB"
                            anchors.verticalCenter: parent.verticalCenter
                            font.pointSize: 12
                            font.family: "Verdana"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                    Rectangle {
                        height: 35
                        width: 1
                        color: "grey"
                    }

                    Rectangle {
                        id: holderMinAmplitude
                        Layout.minimumHeight: 35
                        Layout.maximumHeight: 35
                        Layout.minimumWidth: 171
                        Layout.fillWidth: true
                        Label {
                            id: labelMinAmplitude
                            text: "Min. Amp: " + myModel.MinAmp.toFixed(
                                      2) + " dB"
                            anchors.verticalCenter: parent.verticalCenter
                            font.pointSize: 12
                            font.family: "Verdana"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                    Rectangle {
                        height: 35
                        width: 1
                        color: "grey"
                    }

                    Rectangle {
                        id: holderSpan
                        Layout.minimumHeight: 35
                        Layout.maximumHeight: 35
                        Layout.minimumWidth: 130
                        Layout.fillWidth: true
                        Label {
                            id: labelSpan
                            text: "Span: " + parseFloat(
                                      (varStopFrequency - varStartFrequency)).toFixed(
                                      2) + " MHz"
                            anchors.verticalCenter: parent.verticalCenter
                            font.pointSize: 12
                            font.family: "Verdana"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                    Rectangle {
                        height: 35
                        width: 1
                        color: "grey"
                    }

                    Rectangle {
                        id: holderTime
                        Layout.minimumHeight: 35
                        Layout.maximumHeight: 35
                        Layout.minimumWidth: 70
                        Layout.fillWidth: true
                        Label {
                            id: labelTime
                            text: "00:00"
                            anchors.verticalCenter: parent.verticalCenter
                            font.pointSize: 12
                            font.family: "Verdana"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }
        }
    }
}
