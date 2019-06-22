import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0

Item {
	id: root
	anchors.fill: parent
	anchors.topMargin: 30

	Image {
		id: image
		width: 300
		height: image.width
		anchors.horizontalCenter: parent.horizontalCenter
		source: {
			var data = mpris2Source.currentData;
			return data && data.Metadata ? data.Metadata['mpris:artUrl'] : '';
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
