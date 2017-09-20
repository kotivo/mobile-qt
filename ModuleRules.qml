import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import Qt.labs.settings 1.0
import "Connection.js" as Connection

Rectangle {
	color: '#fff'

	property var module: null

	ScrollView {
		width: app.width
		height: app.height
		ColumnLayout {
			width: app.width
			height: app.height
			Rectangle {
				Layout.fillWidth: true
				Layout.alignment: Qt.AlignTop
				height: 50
				color: '#63be5f'
				Text {
					text: module.label + ' ' + qsTr('säännöt')
					color: '#fff'
					font.pixelSize: 20
					anchors.fill: parent
					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter
				}
			}
			Button {
				text: qsTr('Tallenna')
				Layout.fillWidth: true
				Layout.alignment: Qt.AlignBottom
			}
		}
	}
}

