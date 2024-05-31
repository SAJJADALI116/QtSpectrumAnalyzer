#ifndef DATAMODEL_H
#define DATAMODEL_H

#include <QObject>
#include <QAbstractTableModel>
#include <QList>
#include <QPointF>
#include "Conversion.h"

class DataModel : public QAbstractTableModel
{
    Q_OBJECT
    Q_PROPERTY(float MaxFreq READ MaxFreq NOTIFY MaxFreqChanged FINAL)
    Q_PROPERTY(float MinFreq READ MinFreq NOTIFY MinFreqChanged FINAL)
    Q_PROPERTY(float MaxAmp READ MaxAmp NOTIFY MaxAmpChanged FINAL)
    Q_PROPERTY(float MinAmp READ MinAmp NOTIFY MinAmpChanged FINAL)
public:
    enum {
        ValueRole = Qt::DisplayRole
    };
    explicit DataModel(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent) const;
    int columnCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;
    void addNewPoint(QPointF point);
    float MaxFreq() const;
    float MinFreq() const;
    float MaxAmp() const;
    float MinAmp() const;

signals:
    void MaxFreqChanged();
    void MinFreqChanged();
    void MaxAmpChanged();
    void MinAmpChanged();

public slots:
    void receiveConvertedData(float data);
private:
    QList <QPointF> m_points;
    Conversion *m_convert;
    float frequency = 175;
    float m_MaxFreq = 226;
    float m_MinFreq = 174;
    float m_MaxAmp = 0;
    float m_MinAmp = 0;
};

#endif // DATAMODEL_H
