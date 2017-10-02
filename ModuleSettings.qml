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
				text: module.label + ' ' + qsTr('asetukset')
				Layout.alignment: Qt.AlignTop
				Layout.bottomMargin: 5
				Layout.fillWidth: true
			}

			DialTemperature {
				label_text: qsTr('Turvalämpötila')
				Layout.fillWidth: true
				Layout.alignment: Qt.AlignTop | Qt.AlignLeft
				from: -30
				to: 30
				stepSize: 0.5
				snapMode: Dial.SnapAlways
				value: module.temperature !== undefined ? module.temperature.safety : 0
				visible: module.temperature !== undefined
			}

			Tumbler {
				Layout.leftMargin: 50
				height: 40
				model: 200
				wrap: false
				visibleItemCount: 5
				delegate: Label {
					text: {
						var value = ((Tumbler.tumbler.count / 2) - modelData) / 2;
						return (value >= 0 ? '+' : '') + value.toFixed(1) + ' °C';
					}
					opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter
					font.pointSize: 20
				}
			}

			Button {
				text: qsTr('Tallenna')
				Layout.fillWidth: true
			}
		}
	}
}

