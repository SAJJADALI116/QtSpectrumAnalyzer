#include "DataModel.h"

DataModel::DataModel(QObject *parent)
    : QAbstractTableModel{parent}
{
    m_convert = new Conversion();
    connect(m_convert,SIGNAL(sendConvertedData(float)),this,SLOT(receiveConvertedData(float)));
}

int DataModel::rowCount(const QModelIndex &parent = QModelIndex()) const
{
    return m_points.size();
}

int DataModel::columnCount(const QModelIndex &parent) const
{
    return 2;
}

QVariant DataModel::data(const QModelIndex &index, int role) const
{
    const QPointF point = m_points[index.row()];

    if (index.column() == 0)
    {
        return point.x();
    }
    return point.y();
}

QHash<int, QByteArray> DataModel::roleNames() const
{
    QHash<int, QByteArray> mappings;
    mappings [ValueRole] = "value";
    return mappings;
}

void DataModel::addNewPoint(QPointF point)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_points.append(point);
    endInsertRows();
}

void DataModel::receiveConvertedData(float data)
{
    if (data > m_MaxAmp)
    {
        m_MaxAmp = data;
        emit MaxAmpChanged();
    }
    if (data < m_MinAmp)
    {
        m_MinAmp = data;
        emit MinAmpChanged();
    }
    QPointF point (frequency,data);
    frequency = frequency + 0.05;
    if (frequency == 225)
    {
        frequency = 175;
    }
    addNewPoint(point);
}

float DataModel::MaxFreq() const
{
    return m_MaxFreq;
}

float DataModel::MinFreq() const
{
    return m_MinFreq;
}

float DataModel::MaxAmp() const
{
    return m_MaxAmp;
}

float DataModel::MinAmp() const
{
    return m_MinAmp;
}
