#ifndef TCPPACKETS_H
#define TCPPACKETS_H

#include <QObject>
#include <QTcpServer>
#include <QTcpSocket>

class TCPPackets : public QObject
{
    Q_OBJECT
public:
    explicit TCPPackets(QObject *parent = nullptr);

signals:
    void serverState(QString serverState);
    void hardwareState(QString hardwareState);
    void sendForConversion(QByteArray data);

private slots:
    void hardwareConnectionState();
    void receiveData();
private:
    QTcpServer *m_server;
    QTcpSocket *m_socket;
    void listenToPort();
};

#endif // TCPPACKETS_H
