import Quickshell
import Quickshell.Wayland
import QtQuick

PanelWindow {
    id: calendarWindow

    // Window size follows the calendar's content height
    implicitWidth: cal.implicitWidth
    implicitHeight: cal.implicitHeight

    anchors {
        top: true
        right: true
    }

    margins {
        top: 60
        right: 18
    }

    // Keep it above wallpaper, below normal windows
    WlrLayershell.layer: WlrLayer.Bottom

    exclusiveZone: 0
    focusable: false
    color: "transparent"

    Calendar {
        id: cal
        anchors.fill: parent
    }
}

