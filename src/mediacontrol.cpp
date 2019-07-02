#include "mediacontrol.h"
#include <stdio.h>
#include <QQmlEngine>
#include <QTextStream>
#include <QAudioProbe>
#include <QAudioRecorder>
#include <QAudioBuffer>

#include "aquila/global.h"
#include "aquila/source/generator/SineGenerator.h"
#include "aquila/transform/FftFactory.h"
#include "aquila/tools/TextPlot.h"

MediaControl::MediaControl(QObject *parent, const QVariantList &args)
    : Plasma::Applet(parent, args),
     m_nativeText("Text coming from C++ plugin")
{
	qDebug("Parker");
}

void MediaControl::init() {

	qDebug("Initialized!");

	QAudioRecorder* audioRecorder = new QAudioRecorder;

	QStringList inputs = audioRecorder->audioInputs();
	qDebug(audioRecorder->defaultAudioInput().toLatin1());
	QString selectedInput = audioRecorder->defaultAudioInput();

	foreach (QString input, inputs) {
	    QString description = audioRecorder->audioInputDescription(input);
	    qDebug(input.toLatin1());
	}

	audioRecorder->setAudioInput("alsa:surround21:CARD=Loopback,DEV=0");

	QAudioProbe* audioProbe = new QAudioProbe(this); 
	if (audioProbe->setSource(audioRecorder)) {
	    // Probing succeeded, audioProbe->isValid() should be true.
	    connect(audioProbe, SIGNAL(audioBufferProbed(QAudioBuffer)),
		    this, SLOT(calculateFrequency(QAudioBuffer)));
	}

	audioRecorder->record();
}

void MediaControl::calculateFrequency(QAudioBuffer buffer) {
    printf("Frame Count: %u\n", buffer.frameCount());
    printf("Sample Size: %u\n", buffer.format().sampleSize());
    printf("Sample Type: %u\n", buffer.format().sampleType());

    if (buffer.isValid()) {
	    std::vector<double> vdData(buffer.frameCount());
    	    QAudioBuffer::S16S *data = buffer.data<QAudioBuffer::S16S>();

	    for (int i = 0; i < buffer.frameCount(); i++) {
		vdData[i] = (double) data[i].average();
	    }


	    double dData[vdData.size()];

	    std::copy(vdData.begin(), vdData.end(), dData);

    	    printf("Data Size: %u\n", buffer.format().sampleType());

	    Aquila::TextPlot plt("Input signal");
	    // plt.plot(data, buffer.frameCount());
	    // calculate the FF
	    auto fft = Aquila::FftFactory::getFft(256);
	    Aquila::SpectrumType spectrum = fft->fft(dData);

	    printf("Spectrum Size: %u", spectrum.size());
	    plt.setTitle("Spectrum");
	    plt.plotSpectrum(spectrum);

    	    int halfLength = spectrum.size() / 2;
	    std::vector<double> absSpectrum(halfLength);
     	    for (int i = 0; i < absSpectrum.size(); ++i)
            {
            	absSpectrum[i] = std::abs(spectrum[i]);//returns the magnitude of a complex number
            }

	    printf("Spectrum Size: %u", absSpectrum.size());
    }

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
