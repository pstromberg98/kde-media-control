import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0

Item {
	id: root

	Plasmoid.icon: "user-grace-hopper"
	Plasmoid.switchHeight: units.gridUnit * 10
	Plasmoid.switchWidth: units.gridUnit * 14
	Plasmoid.status: PlasmaCore.Types.PassiveStatus

	Plasmoid.fullRepresentation: Item {
		Rectangle {
			width: 100
			height: 100
			color: "red"
		}
	}

	Plasmoid.compactRepresentation: Item {
		Layout.minimumWidth: 220;

		Image {
			width: parent.height 
			height: parent.height
			id: image

			source: {
				var data = mpris2Source.currentData;
				return data && data.Metadata ? data.Metadata['mpris:artUrl'] : '';
			}

			MouseArea {
				anchors.fill: parent
				onClicked: {
					plasmoid.expanded = !plasmoid.expanded
				}
			}
		}

		Text {
			id: title
			elide: Text.ElideRight
			width: parent.width - image.width;
			text: {
				var data = mpris2Source.currentData;
				return data && data.Metadata ? data.Metadata['xesam:title'] : '';
			}
			font.pixelSize: 21
			color: "white"
			anchors.left: image.right
			anchors.leftMargin: 10
		}	

		Text {
			id: artist
			elide: Text.ElideRight
			text: {
				var data = mpris2Source.currentData;
				return data && data.Metadata ? data.Metadata['xesam:artist'] : '';
			}

			font.pixelSize: 12
			color: "gray"

			anchors.left: image.right
			anchors.top: title.bottom

			anchors.leftMargin: 10
		}

		Item {
			anchors.left: image.right
			anchors.top: artist.bottom

			anchors.topMargin: 13
			anchors.leftMargin: 10
			width: parent.width - image.width - anchors.leftMargin - image.anchors.rightMargin

			Rectangle {
				id: progress
				width: 0
				height: 1
				color: "#62dbaf"
				anchors.left: parent.left
			}	

			Rectangle {
				id: totalTime
				width: parent.width - progress.width
				height: 1
				color: "gray"
				anchors.left: progress.right
			}

			Timer {
				interval: 10 
				running: true
				repeat: true
				onTriggered: {
					progress.width += 0.01;
					if (totalTime.width <= 0) {
						progress.width = 0;
					}

				}
			}
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

