import 'dart:typed_data';

import 'nyx_printer_definition.dart';
import 'nyx_printer_platform_interface.dart';

class NyxPrinter {
  /// get printer service version
  static Future<String?> getServiceVersion() {
    return NyxPrinterPlatform.instance.getServiceVersion();
  }

  /// get printer firmware version
  static Future<String?> getPrinterVersion() {
    return NyxPrinterPlatform.instance.getPrinterVersion();
  }

  /// get printer status [PrinterStatus]
  static Future<int?> getPrinterStatus() {
    return NyxPrinterPlatform.instance.getPrinterStatus();
  }

  static Future<void> paperOut(int px) {
    return NyxPrinterPlatform.instance.paperOut(px);
  }

  static Future<void> paperBack(int px) {
    return NyxPrinterPlatform.instance.paperBack(px);
  }

  static Future<void> printText(String text, PrintTextStyle? style,
      {int? textWidth, PrintAlign? align}) {
    return NyxPrinterPlatform.instance
        .printText(text, style, textWidth: textWidth, align: align);
  }

  static Future<void> printBarcode(String data, int width, int height,
      {BarcodeTextPosition textPosition = BarcodeTextPosition.NO_TEXT,
      PrintAlign align = PrintAlign.LEFT}) {
    return NyxPrinterPlatform.instance.printBarcode(data, width, height,
        textPosition: textPosition, align: align);
  }

  static Future<void> printQrCode(String data, int width, int height,
      {PrintAlign align = PrintAlign.LEFT}) {
    return NyxPrinterPlatform.instance
        .printQrCode(data, width, height, align: align);
  }

  static Future<void> printImage(Uint8List img,
      {ImageType type = ImageType.BLACK_WHITE,
      PrintAlign align = PrintAlign.LEFT}) {
    return NyxPrinterPlatform.instance
        .printImage(img, type: type, align: align);
  }

  /// Print raster bitmap data
  static Future<void> printRasterData(Uint8List data) {
    return NyxPrinterPlatform.instance.printRasterData(data);
  }

  /// Print ESC/POS commands
  static Future<void> printEscposData(Uint8List data) {
    return NyxPrinterPlatform.instance.printEscposData(data);
  }

  /// Print a row of a table
  static Future<void> printTableText(
      List<String> texts, List<int> weights, List<PrintTextStyle> styles) {
    return NyxPrinterPlatform.instance.printTableText(texts, weights, styles);
  }

  /// After printing, feed paper to cutting position
  static Future<void> printEndAutoOut() {
    return NyxPrinterPlatform.instance.printEndAutoOut();
  }

  /// Locate the next label
  static Future<void> labelLocate(int labelHeight, int labelGap) {
    return NyxPrinterPlatform.instance.labelLocate(labelHeight, labelGap);
  }

  /// Label printing ends, paper automatically moves to the tear-off position.
  /// This method must appear in pairs with [labelLocate]
  static Future<void> labelPrintEnd() {
    return NyxPrinterPlatform.instance.labelPrintEnd();
  }

  /// Auto locate label. This method only can be called on the system that has
  /// performed abel learning by [labelDetectAuto]
  static Future<void> labelLocateAuto() {
    return NyxPrinterPlatform.instance.labelLocateAuto();
  }

  /// Label learning by automatic label detection.
  /// This method will start label learning
  static Future<void> labelDetectAuto() {
    return NyxPrinterPlatform.instance.labelDetectAuto();
  }

  /// Label learning has been performed
  static Future<void> hasLabelLearning() {
    return NyxPrinterPlatform.instance.hasLabelLearning();
  }

  /// Clear label learning data
  static Future<void> clearLabelLearning() {
    return NyxPrinterPlatform.instance.clearLabelLearning();
  }

  /// Control the status of the customer display LCD
  /// PrinterService >= v1.6.3
  static Future<void> configLcd(LcdOpt opt) {
    return NyxPrinterPlatform.instance.configLcd(opt);
  }

  /// Show bitmap in customer display LCD
  /// PrinterService version >= v1.5.9
  static Future<void> showLcdImage(Uint8List img) {
    return NyxPrinterPlatform.instance.showLcdImage(img);
  }

  /// Open cash drawer
  /// PrinterService >= v1.6.1
  static Future<void> openCashBox() {
    return NyxPrinterPlatform.instance.openCashBox();
  }
}
