pragma Singleton

import QtQuick 2.7

QtObject {
	property color backgroundLight: '#f2f2f2'
	property color backgroundDark: '#63be5f'

	property color backgroundPresent: backgroundDark
	property color backgroundAway: '#909090'
	property color backgroundError: '#c00000'

	property color textColorLight: '#ffffff'
	property color textColorDark: '#000000'

	property int textFontSizeNormal: 14
	property int textFontSizeMedium: 16
	property int textFontSizeLarge: 20
	property int textFontSizeExtraLarge: 24

	property color shadowColor: '#c0c0c0'
	property int shadowOffsetX: 2
	property int shadowOffsetY: 2
	property int shadowRadius: 3

	property color headerTextColor: '#ffffff'
	property int headerTextSize: textFontSizeLarge
}
