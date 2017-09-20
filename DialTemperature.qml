import QtQuick 2.7
import QtQuick.Controls 2.2

Dial {
	id: control

	property var label_text: null

	background: Rectangle {
		x: control.width / 2 - width / 2
		y: control.height / 2 - height / 2
		width: Math.max(64, Math.min(control.width, control.height))
		height: width
		color: "transparent"
		radius: width / 2
		border.color: control.pressed ? "#17a81a" : "#21be2b"
		opacity: control.enabled ? 1 : 0.3
		Label {
			id: label
			visible: control.label_text != null
			text: control.label_text
			font.pixelSize: 14
			anchors.left: parent.left
			anchors.right: parent.right
			y: control.height / 2 - height
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignBottom
		}
		Text {
			text: control.value.toFixed(1) + ' °C'
			color: '#63be5f'
			font.pixelSize: 26
			anchors.top: label.visible ? label.bottom : parent.top
			anchors.bottom: parent.bottom
			anchors.left: parent.left
			anchors.right: parent.right
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: label.visible ? Text.AlignTop : Text.AlignVCenter
		}
	}

	handle: Rectangle {
		id: handleItem
		x: control.background.x + control.background.width / 2 - width / 2
		y: control.background.y + control.background.height / 2 - height / 2
		width: 20
		height: 20
		color: control.pressed ? "#17a81a" : "#21be2b"
		radius: 10
		antialiasing: true
		opacity: control.enabled ? 1 : 0.3
		transform: [
			Translate {
				y: -Math.min(control.background.width, control.background.height) * 0.48 + handleItem.height / 2
			},
			Rotation {
				angle: control.angle
				origin.x: handleItem.width / 2
				origin.y: handleItem.height / 2
			}
		]
	}
}
