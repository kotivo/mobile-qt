import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

Rectangle {
	width: (parent.width - 10) / Math.max(Math.floor(parent.width / 300), 1)
	height: 100
	color: 'transparent'
	Rectangle {
		anchors.fill: parent
		anchors.margins: 5
		color: '#fff'
		border.width: 1
		border.color: model.connected ? (!model.away ? '#63be5f' : '#8f8f8f') : '#000'
		Rectangle {
			id: moduleHeader
			anchors.top: parent.top
			anchors.left: parent.left
			anchors.right: parent.right
			height: 40
			color: model.connected ? (!model.away ? '#63be5f' : '#8f8f8f') : '#000'
			Text {
				id: moduleLabel
				text: model.label
				color: '#fff'
				font.pixelSize: 20
				anchors.fill: parent
				anchors.leftMargin: 10
				horizontalAlignment: Text.AlignLeft
				verticalAlignment: Text.AlignVCenter
			}
			ToolButton {
				id: moduleRulesButton
				text: '\uf2c7'
				anchors.right: moduleSettingsButton.left
				contentItem: Label {
					text: parent.text
					color: '#cec'
					font.bold: true
					font.pixelSize: 20
					font.family: 'FontAwesome'
					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter
				}
			}
			ToolButton {
				id: moduleSettingsButton
				text: '\uf013'
				anchors.right: parent.right
				contentItem: Label {
					text: parent.text
					color: '#cec'
					font.bold: true
					font.pixelSize: 20
					font.family: 'FontAwesome'
					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter
				}
			}
		}
		Column {
			anchors.top: moduleHeader.bottom
			Layout.fillWidth: true
			Layout.fillHeight: true
			visible: model.connected
			padding: 5

			Row {
				visible: model.temperature !== undefined
				Label {
					text: qsTr('Lämpötila:')
					width: 140
					font.pixelSize: 14
				}
				Text {
					text: parent.visible ? model.temperature.current.toFixed(1) : ''
					color: '#63be5f'
					font.pixelSize: 14
					font.bold: true
				}
			}

			Row {
				visible: model.temperature !== undefined
				Label {
					text: qsTr('Tavoitelämpötila:')
					width: 140
					font.pixelSize: 14
				}
				Text {
					text: parent.visible ? model.temperature.target.toFixed(1) : ''
					color: '#63be5f'
					font.pixelSize: 14
					font.bold: true
				}
			}
		}

		Text {
			text: qsTr('Laite ei ole yhteydessä')
			font.pixelSize: 14
			font.bold: true
			visible: !model.connected
			anchors.top: moduleHeader.bottom
			anchors.bottom: parent.bottom
			anchors.left: parent.left
			anchors.right: moduleAway.left
			anchors.margins: 5
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
		}

		Switch {
			id: moduleAway
			anchors.top: moduleHeader.bottom
			anchors.right: parent.right
			checked: !model.away
		}
	}
}
