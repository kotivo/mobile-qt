import QtQuick 2.7
import QtGraphicalEffects 1.0
import '.'

Rectangle {
	layer.enabled: true
	layer.effect: DropShadow {
		horizontalOffset: Style.shadowOffsetX
		verticalOffset: Style.shadowOffsetY
		color: Style.shadowColor
		radius: Style.shadowRadius
	}
}
