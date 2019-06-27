import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0

Item {
	id: root

	Plasmoid.switchHeight: units.gridUnit * 10
	Plasmoid.switchWidth: units.gridUnit * 14
	Plasmoid.status: PlasmaCore.Types.ActiveStatus

	Plasmoid.fullRepresentation: ExpandedRepresentation {}

	Plasmoid.compactRepresentation: Item {
		Layout.minimumWidth: 250
		anchors.rightMargin: 5
		anchors.leftMargin: 5

		MouseArea {
			anchors.fill: parent
			onClicked: {
				plasmoid.expanded = !plasmoid.expanded
			}
		}

		Image {
			id: image
			width: parent.height 
			height: parent.height

			source: {
				var data = mpris2Source ? mpris2Source.currentData : {};
				return data && data.Metadata ? data.Metadata['mpris:artUrl'] || '' : '';
			}
		}

		Text {
			id: title
			elide: Text.ElideRight
			width: parent.width - image.width;
			text: {
				var data = mpris2Source ? mpris2Source.currentData : {};
				return data && data.Metadata ? data.Metadata['xesam:title'] || '' : '';
			}
			font.pixelSize: 18
			color: "white"
			anchors.left: image.right
			anchors.leftMargin: 10
		}	

		ProgressBar {
			anchors.left: image.right
			anchors.top: title.bottom

			anchors.topMargin: 10
			anchors.leftMargin: 10
			width: parent.width - image.width - anchors.leftMargin - image.anchors.rightMargin
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

