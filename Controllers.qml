import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import Qt.labs.settings 1.0
import QtGraphicalEffects 1.0
import "Connection.js" as Connection

Rectangle {
	color: '#fff'
	ScrollView {
		width: app.width
		height: app.height
		ColumnLayout {
			width: app.width
			height: app.height

			Header {
				text: qsTr('Valitse sijainti')
				Layout.alignment: Qt.AlignTop
				Layout.bottomMargin: 5
				Layout.fillWidth: true
			}

			Flow {
				Layout.fillWidth: true
				Layout.fillHeight: true
				Layout.alignment: Qt.AlignTop
				padding: 5
				Repeater {
					model: ListModel {
						id: controllersModel
					}
					delegate: Controller {

					}
				}
			}
			Timer {
				triggeredOnStart: true
				interval: 5000
				running: true
				repeat: true
				onTriggered: {
					Connection.controllersGet(controllersModel, function() {
						footerMessage.text = qsTr('Yhteysvirhe haettaessa sijainteja');
						footerTimer.start();
						container.pop(app.loginView);
					});
				}
			}
		}
	}
}

