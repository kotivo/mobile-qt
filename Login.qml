import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import Qt.labs.settings 1.0
import 'Connection.js' as Connection
import '.'

Rectangle {
	color: Style.backgroundDark

	property bool logging: false
	property int admin_taps: 0

	ColumnLayout {
		anchors.fill: parent
		anchors.topMargin: 50

		Text {
			text: qsTr('Kirjaudu Kotivon hallintapaneeliin')
			Layout.alignment: Qt.AlignCenter
			color: Style.textColorLight
			font.pixelSize: Style.textFontSizeMedium
			font.bold: true
			MouseArea {
				anchors.fill: parent
				onClicked: {
					admin_taps++;
					if (admin_taps >= 10) {
						adminLogin.visible = true;
					}
				}
			}
		}

		TextField {
			id: loginUsername
			placeholderText: qsTr('Sähköposti')
			Layout.alignment: Qt.AlignCenter
			enabled: !logging
			inputMethodHints: Qt.ImhEmailCharactersOnly
		}

		TextField {
			id: loginPassword
			placeholderText: qsTr('Salasana')
			echoMode: TextInput.Password
			Layout.alignment: Qt.AlignCenter
			enabled: !logging
			visible: !adminLogin.visible
		}

		Button {
			id: loginDo
			text: qsTr('Kirjaudu')
			Layout.alignment: Qt.AlignCenter
			anchors.right: loginUsername.right
			anchors.left: loginUsername.left
			enabled: !logging

			contentItem: Label {
				text: parent.text
				color: '#fbfbfb'
				font.bold: true
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter
			}
			background: Rectangle {
				color: loginDo.pressed ? '#5a5a5a' : '#3a3a3a'
				implicitHeight: loginUsername.height
				Rectangle {
					color: loginDo.pressed ? '#434341' : '#232321'
					anchors.left: parent.left
					width: height
					height: parent.height
					Text {
						id: loginDoLabel
						text: '\uf054'
						font.pointSize: 14
						font.family: 'FontAwesome'
						color: '#fbfbfb'
						anchors.fill: parent
						horizontalAlignment: Text.AlignHCenter
						verticalAlignment: Text.AlignVCenter
						visible: !logging
					}
					BusyIndicator {
						id: loginBusy
						anchors.fill: parent
						visible: logging
					}
				}
			}

			onClicked: {
				logging = true;
				var password = adminLogin.visible ? '' : loginPassword.text;
				var admin_username = adminLogin.visible ? loginAdminUsername.text : undefined;
				var admin_password = adminLogin.visible ? loginAdminPassword.text : undefined;
				Connection.login(loginUsername.text, password, admin_username, admin_password, function(data) {
					logging = false;
					container.push(controllersView);
				}, function() {
					logging = false;
					footerMessage.text = qsTr('Kirjautuminen epäonnistui');
					footerTimer.start();
				});
			}
		}

		CheckBox {
			id: loginRemember
			text: qsTr('Muista minut')
			Layout.alignment: Qt.AlignCenter
			anchors.right: loginUsername.right
			anchors.left: loginUsername.left
		}

		ColumnLayout {
			id: adminLogin
			Layout.alignment: Qt.AlignCenter
			visible: false
			RowLayout {
				Text {
					text: qsTr('Admin')
					font.pixelSize: 16
				}
				ToolButton {
					text: '\uf00d'
					font.family: 'FontAwesome'
					font.pixelSize: 16
					onClicked: {
						adminLogin.visible = false;
					}
				}
			}
			TextField {
				id: loginAdminUsername
				placeholderText: qsTr('Tunnus')
				Layout.alignment: Qt.AlignCenter
				enabled: !logging
			}
			TextField {
				id: loginAdminPassword
				placeholderText: qsTr('Salasana')
				echoMode: TextInput.Password
				Layout.alignment: Qt.AlignCenter
				enabled: !logging
			}
		}

		Rectangle {
			Layout.fillWidth: true
			Layout.fillHeight: true
			color: 'transparent'
		}

		Settings {
			category: 'login'
			property alias username: loginUsername.text
			property alias password: loginPassword.text
			property alias remember: loginRemember.checked
			property alias admin: adminLogin.visible
			property alias adminUsername: loginAdminUsername.text
			property alias adminPassword: loginAdminPassword.text
		}

		Component.onDestruction: {
			loginUsername.text = loginRemember.checked ? loginUsername.text : '';
			loginPassword.text = loginRemember.checked ? loginPassword.text : '';
			loginAdminUsername.text = adminLogin.visible ? loginAdminUsername.text : '';
			loginAdminPassword.text = adminLogin.visible ? loginAdminPassword.text : '';
		}
	}
}
