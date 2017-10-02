import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import Qt.labs.settings 1.0
import QtGraphicalEffects 1.0
import "Connection.js" as Connection

Rectangle {
	color: 'transparent'

	property var controller: { 'label': '' }

	ScrollView {
		width: app.width
		height: app.height
		ColumnLayout {
			width: app.width
			height: app.height

			Header {
				text: controller.label
				Layout.alignment: Qt.AlignTop
				Layout.bottomMargin: 5
				Layout.fillWidth: true
			}

			Flow {
				Layout.fillWidth: true
				Layout.fillHeight: true
				Layout.alignment: Qt.AlignTop
				padding: 7
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

