import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import Qt.labs.settings 1.0
import "Connection.js" as Connection

Rectangle {
	color: '#fff'

	property var controller: null

	ScrollView {
		width: app.width
		height: app.height
		ColumnLayout {
			width: app.width
			height: app.height

			Flow {
				Layout.fillWidth: true
				Layout.fillHeight: true
				Layout.alignment: Qt.AlignTop
				padding: 5
				Repeater {
					model: ListModel {
						id: modulesModel
					}
					delegate: Module {

					}
				}
			}

			Timer {
				triggeredOnStart: true
				interval: 5000
				running: true
				repeat: true
				onTriggered: Connection.modulesGet(controller, modulesModel)
			}
		}
	}
}

