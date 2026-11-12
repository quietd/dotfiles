import QtQuick

Item {
    id: calendar

    // Layout constants
    readonly property int margin: 22
    readonly property int sectionSpacing: 10
    readonly property int headerHeight: 43
    readonly property int weekdayHeight: 22
    readonly property int cellHeight: 34
    readonly property int buttonSize: 32

    // Calendar state
    property date today: new Date()
    property date shownMonth: new Date(
        new Date().getFullYear(),
        new Date().getMonth(),
        1
    )

    // Derived values: only show as many week rows as the month needs
    readonly property int firstDay: shownMonth.getDay()
    readonly property int daysInMonth: new Date(
        shownMonth.getFullYear(),
        shownMonth.getMonth() + 1,
        0
    ).getDate()
    readonly property int rows: Math.ceil((firstDay + daysInMonth) / 7)

    // Size follows content (shell.qml binds to implicitHeight)
    implicitWidth: 280
    implicitHeight: margin * 2
                    + headerHeight
                    + weekdayHeight
                    + sectionSpacing * 2
                    + rows * cellHeight

    function changeMonth(amount) {
        shownMonth = new Date(
            shownMonth.getFullYear(),
            shownMonth.getMonth() + amount,
            1
        )
    }

    function isToday(day) {
        return day.getDate() === today.getDate()
            && day.getMonth() === today.getMonth()
            && day.getFullYear() === today.getFullYear()
    }

    Timer {
        interval: 60000
        running: true
        repeat: true
        onTriggered: calendar.today = new Date()
    }

    Rectangle {
        anchors.fill: parent
        radius: 24
        color: "#cc171719"
        border.color: "#35ffffff"
        border.width: 1

        Column {
            anchors.fill: parent
            anchors.margins: calendar.margin
            spacing: calendar.sectionSpacing

            // Header: month/year + nav buttons
            Item {
                width: parent.width
                height: calendar.headerHeight

                Column {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 3

                    Text {
                        text: Qt.formatDate(calendar.shownMonth, "MMMM")
                        color: "#ffffff"
                        font.pixelSize: 25
                        font.weight: Font.DemiBold
                    }

                    Text {
                        text: Qt.formatDate(calendar.shownMonth, "yyyy")
                        color: "#999999"
                        font.pixelSize: 12
                    }
                }

                Row {
                    anchors.right: parent.right
                    anchors.top: parent.top
                    spacing: 8

                    Rectangle {
                        width: calendar.buttonSize
                        height: calendar.buttonSize
                        radius: calendar.buttonSize / 2
                        color: "#22ffffff"

                        Text {
                            anchors.centerIn: parent
                            text: "‹"
                            color: "white"
                            font.pixelSize: 23
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: calendar.changeMonth(-1)
                        }
                    }

                    Rectangle {
                        width: calendar.buttonSize
                        height: calendar.buttonSize
                        radius: calendar.buttonSize / 2
                        color: "#22ffffff"

                        Text {
                            anchors.centerIn: parent
                            text: "›"
                            color: "white"
                            font.pixelSize: 23
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: calendar.changeMonth(1)
                        }
                    }
                }
            }

            // Weekday letters
            Row {
                width: parent.width
                height: calendar.weekdayHeight

                Repeater {
                    model: ["S", "M", "T", "W", "T", "F", "S"]

                    Text {
                        width: parent.width / 7
                        height: parent.height
                        text: modelData
                        color: "#777777"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 12
                    }
                }
            }

            // Day grid
            Grid {
                width: parent.width
                columns: 7
                spacing: 0

                Repeater {
                    model: calendar.rows * 7

                    delegate: Item {
                        width: parent.width / 7
                        height: calendar.cellHeight

                        property date cellDate: new Date(
                            calendar.shownMonth.getFullYear(),
                            calendar.shownMonth.getMonth(),
                            index - calendar.firstDay + 1
                        )

                        property bool inMonth:
                            cellDate.getMonth() === calendar.shownMonth.getMonth()

                        property bool isToday: calendar.isToday(cellDate)

                        Rectangle {
                            width: 30
                            height: 30
                            radius: 15
                            anchors.centerIn: parent
                            color: isToday ? "#ffffff" : "transparent"
                        }

                        Text {
                            anchors.centerIn: parent
                            text: cellDate.getDate()
                            color: isToday
                                ? "#151515"
                                : (inMonth ? "#eeeeee" : "#555555")
                            font.pixelSize: 13
                            font.weight: isToday ? Font.Bold : Font.Normal
                        }
                    }
                }
            }
        }
    }
}

