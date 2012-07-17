#include "termprefs.h"
#include "ui_TermPrefs.h"
#include "console.h"

TermPrefs::TermPrefs(Console *con) : ui(new Ui::TermPrefs)
{
    ui->setupUi(this);
    serialConsole = con;

    /* setup application registry info */
    QCoreApplication::setOrganizationName(publisherKey);
    QCoreApplication::setOrganizationDomain(publisherComKey);
    QCoreApplication::setApplicationName(ASideGuiKey);

    /* global settings */
    settings = new QSettings(QString(publisherKey), QString(ASideGuiKey));

    /* the order of these settings is critical for read/save */
    settingNames.clear();
    settingNames.append(enableKeyClearScreen);
    settingNames.append(enableKeyHomeCursor);
    settingNames.append(enableKeyPosXYCursor);
    settingNames.append(enableKeyMoveCursorLeft);
    settingNames.append(enableKeyMoveCursorRight);
    settingNames.append(enableKeyMoveCursorUp);
    settingNames.append(enableKeyMoveCursorDown);
    settingNames.append(enableKeyBeepSpeaker);
    settingNames.append(enableKeyBackspace);
    settingNames.append(enableKeyTab);
    settingNames.append(enableKeyCReturn);
    settingNames.append(enableKeyClearToEOL);
    settingNames.append(enableKeyClearLinesBelow);
    settingNames.append(enableKeyNewLine);
    settingNames.append(enableKeyPosCursorX);
    settingNames.append(enableKeyPosCursorY);
    settingNames.append(enableKeyClearScreen16);
    settingNames.append(enableKeyAddNLtoCR);
    settingNames.append(enableKeyAddCRtoNL);


    propertyColors.insert(PColor::Black, new PColor(tr("Black"), Qt::black));
    propertyColors.insert(PColor::DarkGray, new PColor(tr("Dark Gray"), Qt::darkGray));
    propertyColors.insert(PColor::Gray, new PColor(tr("Gray"),Qt::gray));
    propertyColors.insert(PColor::LightGray, new PColor(tr("Light Gray"),Qt::lightGray));
    propertyColors.insert(PColor::Blue, new PColor(tr("Blue"),Qt::blue));
    propertyColors.insert(PColor::DarkBlue, new PColor(tr("Dark Blue"),Qt::darkBlue));
    propertyColors.insert(PColor::Cyan, new PColor(tr("Cyan"),Qt::cyan));
    propertyColors.insert(PColor::DarkCyan, new PColor(tr("Dark Cyan"),Qt::darkCyan));
    propertyColors.insert(PColor::Green, new PColor(tr("Green"),Qt::green));
    propertyColors.insert(PColor::DarkGreen, new PColor(tr("Dark Green"),Qt::darkGreen));
    propertyColors.insert(PColor::Magenta, new PColor(tr("Magenta"),Qt::magenta));
    propertyColors.insert(PColor::DarkMagenta, new PColor(tr("Dark Magenta"),Qt::darkMagenta));
    propertyColors.insert(PColor::Red, new PColor(tr("Red"),Qt::red));
    propertyColors.insert(PColor::DarkRed, new PColor(tr("Dark Red"),Qt::darkRed));
    propertyColors.insert(PColor::Yellow, new PColor(tr("Yellow"),Qt::yellow));
    propertyColors.insert(PColor::DarkYellow, new PColor(tr("Dark Yellow"),Qt::darkYellow));
    propertyColors.insert(PColor::White, new PColor(tr("White"), Qt::white));

    QStringList colorlist;
    for(int n = 0; n < propertyColors.count(); n++) {
        colorlist.append(static_cast<PColor*>(propertyColors[n])->getName());
    }

    addColors(ui->comboBoxBackground,propertyColors);
    addColors(ui->comboBoxForeground,propertyColors);

    connect(ui->btnClearOptions, SIGNAL(clicked()),this,SLOT(resetSettings()));
    connect(ui->btnChooseFont,SIGNAL(clicked()),this,SLOT(chooseFont()));
    connect(ui->buttonBox,SIGNAL(rejected()),this,SLOT(reject()));
    connect(ui->buttonBox, SIGNAL(accepted()),this,SLOT(accept()));

    styleText = "QScrollBar:vertical { background: white; }";
    
    readSettings();
}

TermPrefs::~TermPrefs()
{
    delete settings;
}

void TermPrefs::resetSettings()
{
    QStringList list = settings->allKeys();
    foreach(QString s, list) {
        if(s.indexOf(QString(ASideGuiKey)+"_term")== 0)
            settings->remove(s);
        if(s.indexOf(QString(ASideGuiKey)+"_enable")== 0)
            settings->remove(s);
    }

    readSettings();

    ui->cbClearScreen->setChecked(false);
    ui->cbHomeCursor->setChecked(true);
    ui->cbPositionCursorXY->setChecked(true);
    ui->cbMoveLeft->setChecked(true);
    ui->cbMoveRight->setChecked(true);
    ui->cbMoveUp->setChecked(true);
    ui->cbMoveDown->setChecked(true);
    ui->cbBeepSpeaker->setChecked(true);
    ui->cbBackSpace->setChecked(true);
    ui->cbTab->setChecked(true);
    ui->cbCReturn->setChecked(true);
    ui->cbClearToEOL->setChecked(true);
    ui->cbClearLinesBelow->setChecked(true);
    ui->cbNewLine->setChecked(true);
    ui->cbPositionCursorX->setChecked(true);
    ui->cbPositionCursorY->setChecked(true);
    ui->cbClearScreen16->setChecked(true);
    ui->cbAddCRtoNL->setChecked(false);
    ui->cbAddNLtoCR->setChecked(false);
    ui->cbSwapNLCR->setChecked(false);

    saveSettings();
}

void TermPrefs::chooseFont()
{
    bool ok;
    QFont font = serialConsole->font();
    QString family = font.family();
    int size = font.pixelSize();
    settings->setValue(termKeyFontFamily, family);
    settings->setValue(termKeyFontSize, size);
    font = QFontDialog::getFont(&ok, font, this, tr("Choose Font"));
    if(ok) {
        family = font.family();
        size   = font.pixelSize();
        serialConsole->setFont(font);
        settings->setValue(termKeyFontFamily,font.family());
        settings->setValue(termKeyFontSize,font.pointSize());
        ui->labelFont->setText(font.family()+QString(" (%1)").arg(font.pointSize()));
    }
}

void TermPrefs::addColors(QComboBox *box, QVector<PColor*> pcolor)
{
    for(int n = 0; n < pcolor.count(); n++) {
        QPixmap pixmap(20,20);
        pixmap.fill(pcolor.at(n)->getValue());
        QIcon icon(pixmap);
        box->addItem(icon, static_cast<PColor*>(propertyColors[n])->getName());
    }
}

/*
 * get all options and save to settings
 */
void TermPrefs::saveSettings()
{
    bool enable[Console::EN_LAST];
    bool enableSwap;
    int len = settingNames.count();

    /*
     * get formatting options.
     * options must be in same order as Console::EnableEn ENUM !!!
     */
    int j = 0;

    enable[j] = ui->cbClearScreen->isChecked();
    serialConsole->setEnableClearScreen(enable[j++]);

    enable[j] = ui->cbHomeCursor->isChecked();
    serialConsole->setEnableHomeCursor(enable[j++]);

    enable[j] = ui->cbPositionCursorXY->isChecked();
    serialConsole->setEnablePosXYCursor(enable[j++]);

    enable[j] = ui->cbMoveLeft->isChecked();
    serialConsole->setEnableMoveCursorLeft(enable[j++]);

    enable[j] = ui->cbMoveRight->isChecked();
    serialConsole->setEnableMoveCursorRight(enable[j++]);

    enable[j] = ui->cbMoveUp->isChecked();
    serialConsole->setEnableMoveCursorUp(enable[j++]);

    enable[j] = ui->cbMoveDown->isChecked();
    serialConsole->setEnableMoveCursorDown(enable[j++]);

    enable[j] = ui->cbBeepSpeaker->isChecked();
    serialConsole->setEnableBeepSpeaker(enable[j++]);

    enable[j] = ui->cbBackSpace->isChecked();
    serialConsole->setEnableBackspace(enable[j++]);

    enable[j] = ui->cbTab->isChecked();
    serialConsole->setEnableTab(enable[j++]);

    enable[j] = ui->cbCReturn->isChecked();
    serialConsole->setEnableCReturn(enable[j++]);

    enable[j] = ui->cbClearToEOL->isChecked();
    serialConsole->setEnableClearToEOL(enable[j++]);

    enable[j] = ui->cbClearLinesBelow->isChecked();
    serialConsole->setEnableClearLinesBelow(enable[j++]);

    enable[j] = ui->cbNewLine->isChecked();
    serialConsole->setEnableNewLine(enable[j++]);

    enable[j] = ui->cbPositionCursorX->isChecked();
    serialConsole->setEnablePosCursorX(enable[j++]);

    enable[j] = ui->cbPositionCursorY->isChecked();
    serialConsole->setEnablePosCursorY(enable[j++]);

    enable[j] = ui->cbClearScreen16->isChecked();
    serialConsole->setEnableClearScreen16(enable[j++]);

    enable[j] = ui->cbAddCRtoNL->isChecked();
    serialConsole->setEnableAddCRtoNL(enable[j++]);

    enable[j] = ui->cbAddNLtoCR->isChecked();
    serialConsole->setEnableAddNLtoCR(enable[j++]);

    /*
     * now save "function" settings
     */
    for(int n = 0; n < len; n++) {
        QString key(settingNames[n]);
        settings->setValue(key,enable[n]);
    }

    /*
     * get enable NLCR swap and save.
     */
    enableSwap = ui->cbSwapNLCR->checkState();
    serialConsole->setEnableSwapNLCR(enableSwap);
    settings->setValue(enableKeySwapNLCR,enableSwap);


    /*
     * get foreground and background colors and save.
     */
    settings->setValue(termKeyBackground, ui->comboBoxBackground->currentIndex());
    settings->setValue(termKeyForeground, ui->comboBoxForeground->currentIndex());

    QString fgcolor = static_cast<PColor*>(propertyColors.at(ui->comboBoxForeground->currentIndex()))->getName();
    QString bgcolor = static_cast<PColor*>(propertyColors.at(ui->comboBoxBackground->currentIndex()))->getName();
    if(fgcolor.compare("Dark Yellow") == 0)
        fgcolor = "Olive";
    if(bgcolor.compare("Dark Yellow") == 0)
        bgcolor = "Olive";
    if(fgcolor.compare("Dark Gray") == 0)
        fgcolor = "#606060";
    if(bgcolor.compare("Dark Gray") == 0)
        bgcolor = "#606060";
    serialConsole->setStyleSheet(styleText+"QPlainTextEdit { color: \""+fgcolor+"\";" + "background-color: \""+bgcolor+"\"; }");

    /*
     * get and save user's font.
     */
    QFont font = serialConsole->font();
    QString family = font.family();
    int size = font.pointSize();
    settings->setValue(termKeyFontFamily, family);
    settings->setValue(termKeyFontSize, size);

    /*
     * get and save text wrap mode and page wrap line length.
     */
    int wrap = ui->comboBoxWrapMode->currentIndex();
    int page = ui->spinBoxPageWrap->value();
    settings->setValue(termKeyWrapMode, wrap);
    settings->setValue(termKeyPageLineSize, page);

    if(wrap != 0) // if wrap != 0 use page for wrap
        wrap = page;
    serialConsole->setWrapMode(wrap);


    /*
     * save number of lines for buffer
     */
    int lineindex = ui->comboBoxBufferLines->currentIndex();
    int lines = 512;
    settings->setValue(termKeyBufferLines,lineindex);
    QString s = ui->comboBoxBufferLines->itemText(lineindex);
    if(s.contains("infinite",Qt::CaseInsensitive)) {
        lines = 0; // 0 or -1 says buffer is infinite
    }
    else {
        bool ok = false;
        int temp = s.toInt(&ok, 10);
        if(ok) lines = temp;
    }
    serialConsole->setMaximumBlockCount(lines);

    /*
     * save tab size
     */
    int tabsize = ui->spinBoxTabSize->value();
    settings->setValue(termKeyTabSize, tabsize);
    serialConsole->setTabSize(tabsize);

    /*
     * save hex mode
     */
    bool hex = ui->checkBoxHexMode->isChecked();
    settings->setValue(termKeyHexMode, QVariant(hex));
    serialConsole->setHexMode(hex);

    /*
     * save hex dump mode
     */
    bool hexd = ui->checkBoxHexDump->isChecked();
    settings->setValue(termKeyHexDump, QVariant(hexd));
    serialConsole->setHexDump(hexd);

}

/*
 * read all settings and save to enable options
 */
void TermPrefs::readSettings()
{
    /*
     * read user's formatting settings.
     */
    bool enable[Console::EN_LAST];
    bool enableSwap;

    int len = settingNames.count();
    int n = 0;
    // just for first time startup
    enable[n++] = ui->cbClearScreen->isChecked();
    enable[n++] = ui->cbHomeCursor->isChecked();
    enable[n++] = ui->cbPositionCursorXY->isChecked();
    enable[n++] = ui->cbMoveLeft->isChecked();
    enable[n++] = ui->cbMoveRight->isChecked();
    enable[n++] = ui->cbMoveUp->isChecked();
    enable[n++] = ui->cbMoveDown->isChecked();
    enable[n++] = ui->cbBeepSpeaker->isChecked();
    enable[n++] = ui->cbBackSpace->isChecked();
    enable[n++] = ui->cbTab->isChecked();
    enable[n++] = ui->cbCReturn->isChecked();
    enable[n++] = ui->cbClearToEOL->isChecked();
    enable[n++] = ui->cbClearLinesBelow->isChecked();
    enable[n++] = ui->cbNewLine->isChecked();
    enable[n++] = ui->cbPositionCursorX->isChecked();
    enable[n++] = ui->cbPositionCursorY->isChecked();
    enable[n++] = ui->cbClearScreen16->isChecked();
    enable[n++] = ui->cbAddCRtoNL->isChecked();
    enable[n++] = ui->cbAddNLtoCR->isChecked();
    enable[n++] = ui->cbSwapNLCR->isChecked();

    QVariant var;
    for(n = 0; n < len; n++) {
        QString key(settingNames[n]);
        var = settings->value(key,enable[n]);
        if(var.canConvert(QVariant::Bool)) {
            bool val = var.toBool();
            enable[n] = val;
        }
        else {
            enable[n] = false;
        }
    }

    /*
     * set user's formatting.
     * These must be in the same order as the Console EnableEn ENUM !!!
     */
    int j = 0;

    ui->cbClearScreen->setChecked(enable[j]);
    serialConsole->setEnableClearScreen(enable[j++]);

    ui->cbHomeCursor->setChecked(enable[j]);
    serialConsole->setEnableHomeCursor(enable[j++]);

    ui->cbPositionCursorXY->setChecked(enable[j]);
    serialConsole->setEnablePosXYCursor(enable[j++]);

    ui->cbMoveLeft->setChecked(enable[j]);
    serialConsole->setEnableMoveCursorLeft(enable[j++]);

    ui->cbMoveRight->setChecked(enable[j]);
    serialConsole->setEnableMoveCursorRight(enable[j++]);

    ui->cbMoveUp->setChecked(enable[j]);
    serialConsole->setEnableMoveCursorUp(enable[j++]);

    ui->cbMoveDown->setChecked(enable[j]);
    serialConsole->setEnableMoveCursorDown(enable[j++]);

    ui->cbBeepSpeaker->setChecked(enable[j]);
    serialConsole->setEnableBeepSpeaker(enable[j++]);

    ui->cbBackSpace->setChecked(enable[j]);
    serialConsole->setEnableBackspace(enable[j++]);

    ui->cbTab->setChecked(enable[j]);
    serialConsole->setEnableTab(enable[j++]);

    ui->cbCReturn->setChecked(enable[j]);
    serialConsole->setEnableCReturn(enable[j++]);

    ui->cbClearToEOL->setChecked(enable[j]);
    serialConsole->setEnableClearToEOL(enable[j++]);

    ui->cbClearLinesBelow->setChecked(enable[j]);
    serialConsole->setEnableClearLinesBelow(enable[j++]);

    ui->cbNewLine->setChecked(enable[j]);
    serialConsole->setEnableNewLine(enable[j++]);

    ui->cbPositionCursorX->setChecked(enable[j]);
    serialConsole->setEnablePosCursorX(enable[j++]);

    ui->cbPositionCursorY->setChecked(enable[j]);
    serialConsole->setEnablePosCursorY(enable[j++]);

    ui->cbClearScreen16->setChecked(enable[j]);
    serialConsole->setEnableClearScreen16(enable[j++]);

    ui->cbAddCRtoNL->setChecked(enable[j]);
    serialConsole->setEnableAddCRtoNL(enable[j++]);

    ui->cbAddNLtoCR->setChecked(enable[j]);
    serialConsole->setEnableAddNLtoCR(enable[j++]);


    /*
     * read user's NLCR preference.
     */
    var = settings->value(enableKeySwapNLCR,QVariant(false));
    if(var.canConvert(QVariant::Bool)) {
        bool val = var.toBool();
        enableSwap = val;
    }
    else {
        enableSwap = false;
    }
    ui->cbSwapNLCR->setChecked(enableSwap);
    serialConsole->setEnableSwapNLCR(enableSwap);


    /*
     * read users background setting
     */
    int bgindex = PColor::LightGray;
    var = settings->value(termKeyBackground,QVariant(bgindex));
    if(var.canConvert(QVariant::Int)) {
        bgindex = var.toInt();
    }
    ui->comboBoxBackground->setCurrentIndex(bgindex);

    /*
     * read user's foreground setting.
     */
    int fgindex = PColor::Black;
    var = settings->value(termKeyForeground,QVariant(fgindex));
    if(var.canConvert(QVariant::Int)) {
        fgindex = var.toInt();
    }
    ui->comboBoxForeground->setCurrentIndex(fgindex);

    /*
     * set user's foreground and background with style sheet.
     */
    QString fgcolor = static_cast<PColor*>(propertyColors.at(fgindex))->getName();
    QString bgcolor = static_cast<PColor*>(propertyColors.at(bgindex))->getName();
    if(fgcolor.compare("Dark Yellow") == 0)
        fgcolor = "Olive";
    if(bgcolor.compare("Dark Yellow") == 0)
        bgcolor = "Olive";
    if(fgcolor.compare("Dark Gray") == 0)
        fgcolor = "#606060";
    if(bgcolor.compare("Dark Gray") == 0)
        bgcolor = "#606060";
    serialConsole->setStyleSheet(styleText+"QPlainTextEdit { color: \""+fgcolor+"\";" + "background-color: \""+bgcolor+"\"; }");

    /*
     * setup user's editor font
     */
    QFont font = serialConsole->font();
    QFont dfont("Courier New", 10, QFont::Normal, false);

    QVariant fontv = settings->value(termKeyFontFamily, QVariant(dfont.family()));
    if(fontv.canConvert(QVariant::String)) {
        QString family = fontv.toString();
        font = QFont(family);
    }
    else {
        font = dfont;
    }

    fontv = settings->value(termKeyFontSize, QVariant(font.pointSize()));
    if(fontv.canConvert(QVariant::Int)) {
        int size = fontv.toInt();
        font.setPointSize(size);
    }
    else {
        font.setPointSize(10);
    }
    serialConsole->setFont(font);
    ui->labelFont->setText(font.family()+QString(" (%1)").arg(font.pointSize()));

    /*
     * read wrap. if wrap = 0, then wrap to window, else wrap to page.
     */
    int wrap = 0;
    var = settings->value(termKeyWrapMode, QVariant(0));
    if(var.canConvert(QVariant::Int)) {
        wrap = var.toInt();
        ui->comboBoxWrapMode->setCurrentIndex(wrap);
    }

    /*
     * read page length. wrap = page if wrap not set to window.
     */
    int page = 0;
    var = settings->value(termKeyPageLineSize, QVariant(32));
    if(var.canConvert(QVariant::Int)) {
        page = var.toInt();
        ui->spinBoxPageWrap->setValue(page);
    }
    if(wrap != 0) // if wrap != 0 use page for wrap
        wrap = page;
    serialConsole->setWrapMode(wrap);

    /*
     * read number of lines for buffer
     */
    int lineindex = 0;
    int lines = 512;
    var = settings->value(termKeyBufferLines,QVariant(0));
    if(var.canConvert(QVariant::Int)) {
        lineindex = var.toInt();
        ui->comboBoxBufferLines->setCurrentIndex(lineindex);
        QString s = ui->comboBoxBufferLines->itemText(lineindex);

        if(s.contains("infinite",Qt::CaseInsensitive)) {
            lines = 0; // 0 or -1 says buffer is infinite
        }
        else {
            bool ok = false;
            int temp = s.toInt(&ok, 10);
            if(ok) lines = temp;
        }
    }
    serialConsole->setMaximumBlockCount(lines);

    /*
     * read tab size
     */
    int tabsize = 0;
    var = settings->value(termKeyTabSize, QVariant(8));
    if(var.canConvert(QVariant::Int)) {
        tabsize = var.toInt();
        ui->spinBoxTabSize->setValue(tabsize);
    }
    serialConsole->setTabSize(tabsize);

    /*
     * read hex mode
     */
    bool hex = false;
    var = settings->value(termKeyHexMode, QVariant(hex));
    if(var.canConvert(QVariant::Bool)) {
        hex = var.toBool();
        ui->checkBoxHexMode->setChecked(hex);
    }
    serialConsole->setHexMode(hex);

    /*
     * read hex dump mode
     */
    bool hexdump = true;
    var = settings->value(termKeyHexDump, QVariant(hexdump));
    if(var.canConvert(QVariant::Bool)) {
        hexdump = var.toBool();
        ui->checkBoxHexDump->setChecked(hexdump);
    }
    serialConsole->setHexDump(hexdump);

}

void TermPrefs::showDialog()
{
    readSettings();
    this->show();
}

void TermPrefs::accept()
{
    saveSettings();
    this->hide();
}

void TermPrefs::reject()
{
    readSettings();
    this->hide();
}
