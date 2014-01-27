#include <QApplication>
#include "PortConnectionMonitor.h"
#include "qextserialenumerator.h"

PortConnectionMonitor::PortConnectionMonitor(QObject *parent) :
    QThread(parent)
{
    running = true;
    start();
}

void PortConnectionMonitor::stop()
{
    running = false;
    this->msleep(200); // let run finish. don't terminate it.
}

QStringList PortConnectionMonitor::enumeratePorts()
{
    QList<QextPortInfo> ports = QextSerialEnumerator::getPorts();
    QStringList stringlist;
    QStringList myPortList;
    QString name;
    stringlist << "List of ports:";
    for (int i = 0; i < ports.size(); i++) {
        stringlist << "port name:" << ports.at(i).portName;
        stringlist << "friendly name:" << ports.at(i).friendName;
        stringlist << "physical name:" << ports.at(i).physName;
        stringlist << "enumerator name:" << ports.at(i).enumName;
        stringlist << "vendor ID:" << QString::number(ports.at(i).vendorID, 16);
        stringlist << "product ID:" << QString::number(ports.at(i).productID, 16);
        stringlist << "===================================";
#if defined(Q_WS_WIN32)
        name = ports.at(i).portName;
        myPortList.append(name);
#elif defined(Q_WS_MAC)
        name = ports.at(i).portName;
        if(name.indexOf("usbserial") > -1)
            myPortList.append(name);
#else
        name = "/"+ports.at(i).physName;
        myPortList.append(name);
#endif
    }
    return myPortList;
}

void PortConnectionMonitor::run()
{
    QStringList ports;
    portList = enumeratePorts();
    while(running) {
        QApplication::processEvents();
        this->msleep(100);
        ports = enumeratePorts();
        if(ports != portList) {
            portList = ports;
            emit portChanged();
        }
    }
}
