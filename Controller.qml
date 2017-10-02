import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import "Connection.js" as Connection

Rectangle {
	id: controller
	width: (app.width - 10) / Math.max(Math.floor(app.width / 300), 1)
	height: 120
	color: 'transparent'
	ShadowRectangle {
		anchors.fill: parent
		anchors.margins: 5
		RowLayout {
			anchors.fill: parent
			ColumnLayout {
				anchors.fill: parent
				anchors.leftMargin: 5
				Label {
					id: controllerLabel
					text: model.label
					font.pixelSize: Style.textFontSizeLarge
					Layout.fillWidth: true
				}
				SwitchAway {
					id: controllerAway
					checked: model.profile.away
					visible: model.connected
					onCheckedChanged: Connection.controllerAway(model, checked)
				}
				Text {
					text: qsTr('Yhteysvika')
					visible: !model.connected
				}
			}
			Button {
				id: controllerShowButton
				text: '\uf054'
				Layout.fillHeight: true
				implicitWidth: height / 1.8
				contentItem: Label {
					text: parent.text
					color: Style.textColorLight
					font.bold: true
					font.pixelSize: Style.textFontSizeLarge
					font.family: 'FontAwesome'
					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter
				}
				background: Rectangle {
					anchors.fill: parent
					color: model.connected ? (!controllerAway.checked ? Style.backgroundPresent : Style.backgroundAway) : Style.backgroundError
				}
				onClicked: {
					container.push(modulesView);
					container.currentItem.controller = model;
				}
			}
		}
	}
}
