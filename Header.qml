import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import Qt.labs.settings 1.0

Rectangle {
	id: header
	property string text: ''

	width: parent.width
	height: 50
	color: 'transparent'
	ShadowRectangle {
		anchors.fill: parent
		color: Style.backgroundDark
		Text {
			text: header.text
			color: Style.headerTextColor
			font.pixelSize: Style.headerTextSize
			font.bold: true
			anchors.fill: parent
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
		}
	}
	ToolButton {
		text: '\uf053'
		anchors.left: parent.left
		width: parent.height
		height: parent.height
		contentItem: Label {
			text: parent.text
			color: Style.headerTextColor
			font.pixelSize: Style.headerTextSize
			font.family: 'FontAwesome'
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
		}
		onClicked: container.pop()
	}
}
