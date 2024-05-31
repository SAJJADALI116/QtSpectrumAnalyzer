#ifndef CONVERSION_H
#define CONVERSION_H

#include <QObject>
#include <QBitArray>
#include <QByteArray>
#include "TCPPackets.h"
#include "math.h"

class Conversion : public QObject
{
    Q_OBJECT
public:
    explicit Conversion(QObject *parent = nullptr);
    QBitArray HexToBin(QByteArray DataPacket);
    float BinQnmToDecimal(QBitArray bits);
    float Bin32ToFloat(QBitArray bits);
    void convertData(QByteArray DataPacket);

public slots:
    void getDataForConversion(QByteArray data);
signals:
    void sendConvertedData(float data);
private:
    TCPPackets *m_tcpPackets;
};

#endif // CONVERSION_H
