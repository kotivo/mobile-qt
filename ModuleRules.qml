import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import Qt.labs.settings 1.0
import "Connection.js" as Connection

Rectangle {
	color: '#fff'

	property var module: { 'label': '' }

	ScrollView {
		width: app.width
		height: app.height
		ColumnLayout {
			width: app.width
			height: app.height

			Header {
				text: module.label + ' ' + qsTr('säännöt')
				Layout.alignment: Qt.AlignTop
				Layout.bottomMargin: 5
				Layout.fillWidth: true
			}

			Button {
				text: qsTr('Tallenna')
				Layout.fillWidth: true
				Layout.alignment: Qt.AlignBottom
			}
		}
	}
}

