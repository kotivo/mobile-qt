import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import 'Connection.js' as Connection
import '.'

Rectangle {
	width: (parent.width - 14) / Math.max(Math.floor(parent.width / 300), 1)
	height: 120
	color: 'transparent'
	ShadowRectangle {
		anchors.fill: parent
		anchors.margins: 7
		Rectangle {
			id: moduleHeader
			anchors.top: parent.top
			anchors.left: parent.left
			anchors.right: parent.right
			height: 40
			color: model.connected ? (!moduleAway.checked ? Style.backgroundPresent : Style.backgroundAway) : Style.backgroundError
			Text {
				id: moduleLabel
				text: model.label
				color: Style.textColorLight
				font.pixelSize: Style.textFontSizeLarge
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
					color: Style.textColorLight
					font.bold: true
					font.pixelSize: Style.textFontSizeLarge
					font.family: 'FontAwesome'
					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter
				}
				onClicked: {
					container.push(moduleRulesView);
					container.currentItem.module = model;
				}
			}
			ToolButton {
				id: moduleSettingsButton
				text: '\uf013'
				anchors.right: parent.right
				contentItem: Label {
					text: parent.text
					color: Style.textColorLight
					font.bold: true
					font.pixelSize: Style.textFontSizeLarge
					font.family: 'FontAwesome'
					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter
				}
				onClicked: {
					container.push(moduleSettingsView);
					container.currentItem.module = model;
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
					font.pixelSize: Style.textFontSizeNormal
				}
				Text {
					text: parent.visible ? model.temperature.current.toFixed(1) : ''
					color: Style.textColorDark
					font.pixelSize: Style.textFontSizeNormal
					font.bold: true
				}
			}

			Row {
				visible: model.temperature !== undefined
				Label {
					text: qsTr('Tavoitelämpötila:')
					width: 140
					font.pixelSize: Style.textFontSizeNormal
				}
				Text {
					text: parent.visible ? model.temperature.target.toFixed(1) : ''
					color: Style.textColorDark
					font.pixelSize: Style.textFontSizeNormal
					font.bold: true
				}
			}

			Row {
				visible: model.humidity !== undefined
				Label {
					text: qsTr('Kosteus:')
					width: 140
					font.pixelSize: Style.textFontSizeNormal
				}
				Text {
					text: parent.visible ? model.humidity.current.toFixed(1) + '%' : ''
					color: Style.textColorDark
					font.pixelSize: Style.textFontSizeNormal
					font.bold: true
				}
			}
		}

		Text {
			text: qsTr('Laite ei ole yhteydessä')
			font.pixelSize: Style.textFontSizeNormal
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

		SwitchAway {
			id: moduleAway
			anchors.top: moduleHeader.bottom
			anchors.right: parent.right
			checked: model.away
			onCheckedChanged: Connection.moduleAway(controller, model, checked)
		}
	}
}
