#ifndef mediacontrol_H
#define mediacontrol_H


#include <Plasma/Applet>

class MediaControl : public Plasma::Applet
{
    Q_OBJECT
    Q_PROPERTY(QString nativeText READ nativeText CONSTANT)

public:
    void init() override;	

public:
    MediaControl( QObject *parent, const QVariantList &args );
    ~MediaControl();

    QString nativeText() const;

private:
    QString m_nativeText;
};

#endif
