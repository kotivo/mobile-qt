import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import '.'

Switch {
	id: control
	font.pixelSize: Style.textFontSizeLarge

	property var text_present: qsTr('Paikalla')
	property var text_away: qsTr('Poissa')

	indicator: Rectangle {
		implicitWidth: 80
		implicitHeight: 30 + control.font.pixelSize + 5
		x: control.leftPadding
		y: parent.height / 2 - height / 2
		color: 'transparent'
		Text {
			text: !control.checked ? control.text_present : control.text_away
			font: control.font
			color: !control.checked ? Style.backgroundPresent : Style.backgroundAway
			horizontalAlignment: Text.AlignHCenter
			width: 80
		}
		Rectangle {
			x: control.leftPadding
			y: 30 / 2 - height / 2 + control.font.pixelSize + 5
			width: parent.width - (control.rightPadding + control.leftPadding)
			height: 20
			color: !control.checked ? Style.backgroundPresent : Style.backgroundAway
			radius: 10
		}
		Rectangle {
			x: !control.checked ? parent.width - width : 0
			y: control.font.pixelSize + 5
			width: 30
			height: 30
			radius: 15
			color: !control.checked ? '#fff' : '#fff'
			border.color: Style.backgroundAway
		}
	}
}
