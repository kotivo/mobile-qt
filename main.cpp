#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFont>
#include <QFontDatabase>
#include <QDebug>

int main(int argc, char *argv[])
{
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
	QGuiApplication app(argc, argv);

	QFontDatabase::addApplicationFont(":/fontawesome-webfont.ttf");

	QFont font("Arial Black");
	font.setStyleHint(QFont::SansSerif);
	app.setFont(font);

	app.setOrganizationName("Kotivo Oy");
	app.setOrganizationDomain("kotivo.fi");
	app.setApplicationName("Oma Kotivo");

	QQmlApplicationEngine engine;
	engine.load(QUrl(QLatin1String("qrc:/App.qml")));

	return app.exec();
}
