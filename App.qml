import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "Connection.js" as Connection

ApplicationWindow {
	id: app
	visible: true
	width: 720
	height: 1000
	title: qsTr('Oma Kotivo')
	color: '#fff'

	StackView {
		id: container
		initialItem: loginView
		anchors.fill: parent
	}

	Component {
		id: loginView
		Login {
		}
	}
	Component {
		id: controllersView
		Controllers {
		}
	}
	Component {
		id: modulesView
		Modules {
		}
	}

	footer: Rectangle {
		id: footer
		height: 40
		color: '#f32'
		visible: footerTimer.running
		Text {
			id: footerMessage
			text: 'virhe'
			anchors.fill: parent
			font.pointSize: 14
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
		}
		Timer {
			id: footerTimer
			interval: 5000
			running: false
			repeat: false
		}
	}

	onClosing: {
		if (container.depth <= 1) {
			close.accepted = true;
		} else {
			container.pop();
			close.accepted = false;
			if (container.depth <= 1) {
				Connection.logout();
			}
		}
	}
}
