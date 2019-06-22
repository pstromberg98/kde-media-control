import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.12
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0

Item {
	id: root
	anchors.fill: parent
	anchors.topMargin: 30

	Image {
		id: image

		width: 250
		height: image.width
		anchors.horizontalCenter: parent.horizontalCenter
		source: {
			var data = mpris2Source.currentData;
			return data && data.Metadata ? data.Metadata['mpris:artUrl'] : '';
		}

		layer.enabled: true
		layer.effect: DropShadow {
			samples: 18 
			radius: 15
		}
	}

	Item {
		anchors.top: image.bottom
		anchors.topMargin: 35
		anchors.horizontalCenter: parent.horizontalCenter

		Text {
			id: title

			color: "white"
			anchors.horizontalCenter: parent.horizontalCenter
			font.pixelSize: 20
			text: {
				var data = mpris2Source.currentData;
				return data && data.Metadata ? data.Metadata['xesam:artist'] + ' - ' + data.Metadata['xesam:title'] : '';
			}
		}

		Text {
			id: album

			color: "gray"
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.top: title.bottom
			anchors.topMargin: 5
			font.pixelSize: 15

			text: {
				var data = mpris2Source.currentData;
				return data && data.Metadata ? data.Metadata['xesam:album'] : '';
			}
		}

		ProgressBar {
			anchors.top: album.bottom
			anchors.topMargin: 15
			anchors.horizontalCenter: parent.horizontalCenter
			width: root.width
		}
	}



	PlasmaCore.DataSource {
		id: mpris2Source

		readonly property string multiplexSource: "@multiplex"
		property string current: multiplexSource

		readonly property var currentData: data[current]

		engine: "mpris2"
		connectedSources: current

		onSourceRemoved: {
		    // if player is closed, reset to multiplex source
		    if (source === current) {
			current = multiplexSource
		    }
		}
    }
}
