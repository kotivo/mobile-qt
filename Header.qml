import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import Qt.labs.settings 1.0
import QtGraphicalEffects 1.0

Rectangle {
	id: header
	property string text: ''

	width: parent.width
	height: 50
	color: 'transparent'
	Rectangle {
		anchors.fill: parent
		color: '#63be5f'
		Text {
			text: header.text
			color: '#fff'
			font.pixelSize: 20
			anchors.fill: parent
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
		}
		layer.enabled: true
		layer.effect: DropShadow {
			horizontalOffset: 0
			verticalOffset: 3
			color: '#888'
			radius: 5
		}
	}
	ToolButton {
		text: '\uf053'
		anchors.left: parent.left
		width: parent.height
		height: parent.height
		contentItem: Label {
			text: parent.text
			color: '#fff'
			font.pixelSize: 20
			font.family: 'FontAwesome'
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
		}
		onClicked: container.pop()
	}
}
