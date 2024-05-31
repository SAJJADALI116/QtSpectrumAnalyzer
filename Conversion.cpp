#include "Conversion.h"

Conversion::Conversion(QObject *parent)
    : QObject{parent}
{
    m_tcpPackets = new TCPPackets(this);
    connect(m_tcpPackets,SIGNAL(sendForConversion(QByteArray)),this,SLOT(getDataForConversion(QByteArray)));
}

QBitArray Conversion :: HexToBin(QByteArray DataPacket)
{
    qInfo() << DataPacket;
    if (DataPacket[1] == 'x')
    {
        DataPacket.remove(0,2);
    }
    QBitArray bits(DataPacket.size() * 4);
    for (int i = 0; i < DataPacket.size(); i++)
    {
        switch (DataPacket[i])
        {
        case '0':
            bits.setBit(i*4+0, 0);
            bits.setBit(i*4+1, 0);
            bits.setBit(i*4+2, 0);
            bits.setBit(i*4+3, 0);
            break;
        case '1':
            bits.setBit(i*4+0, 0);
            bits.setBit(i*4+1, 0);
            bits.setBit(i*4+2, 0);
            bits.setBit(i*4+3, 1);
            break;
        case '2':
            bits.setBit(i*4+0, 0);
            bits.setBit(i*4+1, 0);
            bits.setBit(i*4+2, 1);
            bits.setBit(i*4+3, 0);
            break;
        case '3':
            bits.setBit(i*4+0, 0);
            bits.setBit(i*4+1, 0);
            bits.setBit(i*4+2, 1);
            bits.setBit(i*4+3, 1);
            break;
        case '4':
            bits.setBit(i*4+0, 0);
            bits.setBit(i*4+1, 1);
            bits.setBit(i*4+2, 0);
            bits.setBit(i*4+3, 0);
            break;
        case '5':
            bits.setBit(i*4+0, 0);
            bits.setBit(i*4+1, 1);
            bits.setBit(i*4+2, 0);
            bits.setBit(i*4+3, 1);
            break;
        case '6':
            bits.setBit(i*4+0, 0);
            bits.setBit(i*4+1, 1);
            bits.setBit(i*4+2, 1);
            bits.setBit(i*4+3, 0);
            break;
        case '7':
            bits.setBit(i*4+0, 0);
            bits.setBit(i*4+1, 1);
            bits.setBit(i*4+2, 1);
            bits.setBit(i*4+3, 1);
            break;
        case '8':
            bits.setBit(i*4+0, 1);
            bits.setBit(i*4+1, 0);
            bits.setBit(i*4+2, 0);
            bits.setBit(i*4+3, 0);
            break;
        case '9':
            bits.setBit(i*4+0, 1);
            bits.setBit(i*4+1, 0);
            bits.setBit(i*4+2, 0);
            bits.setBit(i*4+3, 1);
            break;
        case 'A':
            bits.setBit(i*4+0, 1);
            bits.setBit(i*4+1, 0);
            bits.setBit(i*4+2, 1);
            bits.setBit(i*4+3, 0);
            break;
        case 'a':
            bits.setBit(i*4+0, 1);
            bits.setBit(i*4+1, 0);
            bits.setBit(i*4+2, 1);
            bits.setBit(i*4+3, 0);
            break;
        case 'B':
            bits.setBit(i*4+0, 1);
            bits.setBit(i*4+1, 0);
            bits.setBit(i*4+2, 1);
            bits.setBit(i*4+3, 1);
            break;
        case 'b':
            bits.setBit(i*4+0, 1);
            bits.setBit(i*4+1, 0);
            bits.setBit(i*4+2, 1);
            bits.setBit(i*4+3, 1);
            break;
        case 'C':
            bits.setBit(i*4+0, 1);
            bits.setBit(i*4+1, 1);
            bits.setBit(i*4+2, 0);
            bits.setBit(i*4+3, 0);
            break;
        case 'c':
            bits.setBit(i*4+0, 1);
            bits.setBit(i*4+1, 1);
            bits.setBit(i*4+2, 0);
            bits.setBit(i*4+3, 0);
            break;
        case 'D':
            bits.setBit(i*4+0, 1);
            bits.setBit(i*4+1, 1);
            bits.setBit(i*4+2, 0);
            bits.setBit(i*4+3, 1);
            break;
        case 'd':
            bits.setBit(i*4+0, 1);
            bits.setBit(i*4+1, 1);
            bits.setBit(i*4+2, 0);
            bits.setBit(i*4+3, 1);
            break;
        case 'E':
            bits.setBit(i*4+0, 1);
            bits.setBit(i*4+1, 1);
            bits.setBit(i*4+2, 1);
            bits.setBit(i*4+3, 0);
            break;
        case 'e':
            bits.setBit(i*4+0, 1);
            bits.setBit(i*4+1, 1);
            bits.setBit(i*4+2, 1);
            bits.setBit(i*4+3, 0);
            break;
        case 'F':
            bits.setBit(i*4+0, 1);
            bits.setBit(i*4+1, 1);
            bits.setBit(i*4+2, 1);
            bits.setBit(i*4+3, 1);
            break;
        case 'f':
            bits.setBit(i*4+0, 1);
            bits.setBit(i*4+1, 1);
            bits.setBit(i*4+2, 1);
            bits.setBit(i*4+3, 1);
            break;
        }
    }
    qInfo() << bits;
    return bits;
}

float Conversion :: BinQnmToDecimal(QBitArray bits)
{
    float QnmConvert;
    if (bits[0] == 0)
    {
        //qInfo() << "Positive";
        QnmConvert = 0;
        for (int i = 1; i < bits.size(); i++)
        {
            QnmConvert = QnmConvert + (bits[i] * pow(2, -i));
        }
        return QnmConvert;
    }
    else
    {
        //qInfo() << "Negative";
        QnmConvert = 0;
        for (int i = 1; i < bits.size(); i++)
        {
            QnmConvert = (QnmConvert + (bits[i] * pow(2, -i)));
        }
        QnmConvert = -1 * QnmConvert;
        return QnmConvert;
    }
}

float Conversion :: Bin32ToFloat(QBitArray bits)
{
    QBitArray signBit(1);
    QBitArray exponentBits(8);
    QBitArray mantissaBits(23);
    float exponentPart = 0;
    float mantissaPart = 0;
    float dummy = 0;
    float result = 0;
    signBit[0] = bits[0];
    for (int i = 1; i < 9; i++)
    {
        exponentBits[i-1] = bits[i];
    }
    for (int i = 9; i < 32; i++)
    {
        mantissaBits[i-9] = bits[i];
    }
    for (int i = 0; i < 8; i++)
    {
        dummy = dummy + exponentBits[i] * pow(2,7-i);
    }
    exponentPart = pow(2,(dummy - 127));
    for (int i = 0; i < 23; i++)
    {
        mantissaPart = mantissaPart + (mantissaBits[i] * pow(2, -(i+1)));
    }
    qInfo() << "Sign: " << signBit;
    qInfo() << "Exponent: " << exponentPart;
    qInfo() << "Mantissa: " << mantissaPart;
    if (signBit[0] == 0)
    {
        mantissaPart = mantissaPart + 1;
        result = exponentPart * mantissaPart;
        return result;
    }
    else
    {
        mantissaPart = mantissaPart;
        result = -1 * exponentPart * mantissaPart;
        return result;
    }
}

void Conversion::convertData(QByteArray DataPacket)
{
    //QBitArray bits = HexToBin(DataPacket);
    //float QnmConvert = BinQnmToDecimal(bits);
    //float FloatConvert = Bin32ToFloat(bits)*pow(10,38);
    float FloatConvert = DataPacket.toFloat()/10;
    //qInfo() << bits;
    qInfo() << FloatConvert;
    emit sendConvertedData(FloatConvert);
}

void Conversion::getDataForConversion(QByteArray data)
{
    QByteArray DataPacket = data;
    convertData(DataPacket);
}

