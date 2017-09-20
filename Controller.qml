import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import "Connection.js" as Connection

Rectangle {
	id: controller
	width: (app.width - 10) / Math.max(Math.floor(app.width / 300), 1)
	height: 120
	color: 'transparent'
	Rectangle {
		anchors.fill: parent
		anchors.margins: 5
		color: '#fff'
		border.color: model.connected ? (!controllerAway.checked ? '#63be5f' : '#8f8f8f') : '#000'
		RowLayout {
			anchors.fill: parent
			ColumnLayout {
				anchors.fill: parent
				anchors.leftMargin: 5
				Label {
					id: controllerLabel
					text: model.label
					font.pixelSize: 20
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
				text: '\uf061'
				Layout.fillHeight: true
				implicitWidth: height
				contentItem: Label {
					text: parent.text
					color: '#fbfbfb'
					font.bold: true
					font.pixelSize: 50
					font.family: 'FontAwesome'
					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter
				}
				background: Rectangle {
					anchors.fill: parent
					color: model.connected ? (!controllerAway.checked ? '#63be5f' : '#8f8f8f') : '#000'
				}
				onClicked: {
					container.push(controllerView);
					container.currentItem.controller = model;
				}
			}
		}
	}
}