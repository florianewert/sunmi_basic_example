/**
* JIUI V1 print service
* AIDL Version: 1.1
*/

package woyou.aidlservice.jiuiv5;

import woyou.aidlservice.jiuiv5.ICallback;
import android.graphics.Bitmap;

interface IWoyouService
{
/**
* Printer firmware upgrade (only for system components to call, developers call invalid)
* @param buffer
* @param size
* @param filename
* @param iapInterface
*/
void updateFirmware();

/**
* Printer firmware status
* return: 0--unknown, A5--bootloader, C3--print
*/
int getFirmwareStatus();

/**
* Take WoyouService service version
*/
String getServiceVersion();

/**
* Initialize the printer, reset the logic program of the printer, but do not clear the data in the buffer area, so
* Incomplete print jobs will continue after reset
* @param callback callback
* @return
*/
void printerInit(in ICallback callback);

/**
* Printer self-test, the printer will print a self-test page
* @param callback callback
*/
void printerSelfChecking(in ICallback callback);

/**
* Get the serial number of the printer board
*/
String getPrinterSerialNo();

/**
* Get the printer firmware version number
*/
String getPrinterVersion();

/**
* Get printer model
*/
String getPrinterModal();

/**
* Get the print length of the print head
*/
int getPrintedLength();

/**
* The printer feeds paper (mandatory line feed, feeds paper n lines after finishing the previous printing content)
* @param n: number of paper lines
* @param callback result callback
* @return
*/
void lineWrap(int n, in ICallback callback);

/**
* Print using original instructions
* @param data command
* @param callback result callback
*/
void sendRAWData(in byte[] data, in ICallback callback);

/**
* Setting the alignment mode will affect subsequent printing, unless initialized
* @param alignment: alignment 0--left, 1--center, 2--right
* @param callback result callback
*/
void setAlignment(int alignment, in ICallback callback);

/**
* Setting the print font will affect subsequent printing unless it is initialized
* (Currently only one font "gh" is supported, gh is a monospaced Chinese font, and more font options will be provided later)
* @param typeface: font name
*/
void setFontName(String typeface, in ICallback callback);

/**
* Setting the font size will affect subsequent printing, unless initialized
* Note: The font size is a printing method that exceeds the standard international directives.
* Adjusting the font size will affect the character width, and the number of characters in each line will also change accordingly.
* Therefore, the typesetting formed by the monospace font may be messy
* @param fontsize: font size
*/
void setFontSize(float fontsize, in ICallback callback);

/**
* Print the text, the text width is full of one line and it will automatically wrap and type, and the whole line will not be printed unless it is forced to wrap.
* @param text: the text string to be printed
*/
void printText(String text, in ICallback callback);

/**
* Print the text in the specified font, the font setting is only valid for this time
* @param text: To print the text
* @param typeface: font name (currently only "gh" font is supported)
* @param fontsize: font size
*/
void printTextWithFont(String text, String typeface, float fontsize, in ICallback callback);

/**
* Print a row of the table, you can specify the column width and alignment
* @param colsTextArr each column text string array
* @param colsWidthArr each column width array (calculated in English characters, each Chinese character occupies two English characters, each width is greater than 0)
* @param colsAlign Alignment of each column (0 to the left, 1 to the center, 2 to the right)
* Note: The length of the array of the three parameters should be the same, if the width of colsText[i] is greater than colsWidth[i], the text will wrap
*/
void printColumnsText(in String[] colsTextArr, in int[] colsWidthArr, in int[] colsAlign, in ICallback callback);


/**
* Print pictures
* @param bitmap: Image bitmap object (maximum width of 384 pixels, can’t be printed if it exceeds, and callback exception function is called back)
*/
void printBitmap(in Bitmap bitmap, in ICallback callback);

/**
* Print one-dimensional barcode
* @param data: barcode data
* @param symbology: barcode type
* 0 - UPC-A,
* 1 - UPC-E,
* 2 - JAN13(EAN13),
* 3 - JAN8(EAN8),
* 4 - CODE39,
* 5 - ITF,
* 6 - CODABAR,
* 7 - CODE93,
* 8 - CODE128
* @param height: barcode height, value 1 to 255, default 162
* @param width: barcode width, value 2 to 6, default 2
* @param textposition: text position 0--do not print text, 1--text above the barcode, 2--text below the barcode, 3--print both above and below the barcode
*/
void printBarCode(String data, int symbology, int height, int width, int textposition, in ICallback callback);

/**
* Print two-dimensional barcode
* @param data: QR code data
* @param modulesize: QR code block size (unit: point, value 1 to 16)
* @param errorlevel: QR code error correction level (0 to 3),
* 0 - Error correction level L (7%),
* 1 - Error correction level M (15%),
* 2 - Error correction level Q (25%),
* 3 - Error correction level H (30%)
*/
void printQRCode(String data, int modulesize, int errorlevel, in ICallback callback);

/**
* Print the text, the text width is full of one line and automatically wrap the typesetting, and the whole line will not be printed unless it is forced to wrap
* The text is output as the vector text width, that is, the width of each character is not equal
* @param text: the text string to be printed
* Added in Ver 1.7.6
*/
void printOriginalText(String text, in ICallback callback);

/**
* Print buffer content
*/
void commitPrinterBuffer();

/**
*Cut paper
*/
void cutPaper(in ICallback callback);

/**
* Get the number of cutters
*/
int getCutPaperTimes();

/**
* Open the cash drawer
*/
void openDrawer(in ICallback callback);

/**
* Cumulative opening times of cash drawer
*/
int getOpenDrawerTimes();

/**
* Enter buffer mode, all print calls will be buffered, and print after calling commitPrinterBuffe()
*
* @param clean: Whether to clear the buffer content
*
*/
void enterPrinterBuffer(in boolean clean);

/**
* Exit buffer mode
*
* @param commit: Whether to print out the buffer content
*
*/
void exitPrinterBuffer(in boolean commit);
}