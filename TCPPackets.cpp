#include "TCPPackets.h"

TCPPackets::TCPPackets(QObject *parent)
    : QObject{parent}
{
    m_socket = new QTcpSocket(this);
    m_server = new QTcpServer(this);
    listenToPort();
    connect(m_server,SIGNAL(newConnection()),this,SLOT(hardwareConnectionState()));
}

void TCPPackets::listenToPort()
{
    if(!m_server->listen(QHostAddress::Any, 1234))
    {
        qInfo() << "There is some issue with server.";
        QString errorNote = m_server->errorString();
        emit serverState(errorNote);
    }
    else
    {
        qInfo() << "Waiting for Hardware to be Connected.";
        emit serverState("Waiting for Hardware to be Connected.");
    }
}

void TCPPackets::hardwareConnectionState()
{
    qInfo() << m_socket->state();
    m_socket = m_server->nextPendingConnection();
    qInfo() << m_socket->state();
    qInfo() << "Hardware Connected.";
    emit hardwareState("Hardware Connected.");
    connect(m_socket,SIGNAL(readyRead()),this,SLOT(receiveData()));
}

void TCPPackets::receiveData()
{
    QByteArray data;
    data = m_socket->readAll();
    qInfo() << data;
    emit sendForConversion(data);
}
