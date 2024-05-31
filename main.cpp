#include <QApplication>
#include <QQmlApplicationEngine>
#include "DataModel.h"
int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    qmlRegisterType<DataModel>("DataModel",1,0,"DataModel");
    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/18-BackendFinal/main.qml"_qs);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
