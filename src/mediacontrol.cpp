#include "mediacontrol.h"
#include <stdio.h>
#include <QQmlEngine>
#include <QTextStream>

MediaControl::MediaControl(QObject *parent, const QVariantList &args)
    : Plasma::Applet(parent, args),
     m_nativeText("Text coming from C++ plugin")
{
	qDebug("Parker");
}

void MediaControl::init() {
	qDebug("Initialized!");
}


MediaControl::~MediaControl()
{
}

QString MediaControl::nativeText() const
{
    return m_nativeText;
}


K_EXPORT_PLASMA_APPLET_WITH_JSON(mediacontrol, MediaControl, "metadata.json")


#include "mediacontrol.moc"
