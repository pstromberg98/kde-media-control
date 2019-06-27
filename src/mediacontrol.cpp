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
	QString selectedInput = audioRecorder->defaultAudioInput();

	foreach (QString input, inputs) {
	    QString description = audioRecorder->audioInputDescription(input);
	    qDebug(description.toLatin1());
	}

	audioRecorder->setAudioInput(selectedInput);

	QAudioProbe* audioProbe = new QAudioProbe(this);

	if (audioProbe->setSource(audioRecorder)) {
	    // Probing succeeded, audioProbe->isValid() should be true.
	    connect(audioProbe, SIGNAL(audioBufferProbed(QAudioBuffer)),
		    this, SLOT(calculateLevel(QAudioBuffer)));
	}

	audioRecorder->record();
}

void MediaControl::calculateFrequency(QAudioBuffer buffer) {
    return;
    // input signal parameters
    const std::size_t SIZE = 64;
    const Aquila::FrequencyType sampleFreq = 2000;
    const Aquila::FrequencyType f1 = 125, f2 = 700;

    Aquila::SineGenerator sineGenerator1 = Aquila::SineGenerator(sampleFreq);
    sineGenerator1.setAmplitude(32).setFrequency(f1).generate(SIZE);
    Aquila::SineGenerator sineGenerator2 = Aquila::SineGenerator(sampleFreq);
    sineGenerator2.setAmplitude(8).setFrequency(f2).setPhase(0.75).generate(SIZE);
    auto sum = sineGenerator1 + sineGenerator2;

    Aquila::TextPlot plt("Input signal");
    plt.plot(sum);

    // calculate the FFT
    auto fft = Aquila::FftFactory::getFft(SIZE);
    Aquila::SpectrumType spectrum = fft->fft(sum.toArray());

    plt.setTitle("Spectrum");
    plt.plotSpectrum(spectrum);
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
