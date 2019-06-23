import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0

Item {
	id: root

	Rectangle {
		id: progress
		width: 0
		height: 4
		color: "white"
		anchors.left: parent.left
	}	

	Rectangle {
		id: totalTime
		width: parent.width - progress.width
		height: 4
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
