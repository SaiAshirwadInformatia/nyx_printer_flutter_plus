import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:nyx_printer_flutter/nyx_printer.dart';
import 'package:nyx_printer_flutter/nyx_printer_definition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _log = '';
  String _printerVersion = '';
  String _serviceVersion = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    _getPrinterVersion();
    _getServiceVersion();
  }

  _getPrinterVersion() async {
    try {
      _printerVersion = (await NyxPrinter.getPrinterVersion())!;
    } on PlatformException catch (e) {
      _log += "getPrinterVersion error: ${e.code}, ${e.message}\n";
    }
    setState(() {});
  }

  _getServiceVersion() async {
    try {
      _serviceVersion = (await NyxPrinter.getServiceVersion())!;
    } on PlatformException catch (e) {
      _log += "getServiceVersion error: ${e.code}, ${e.message}\n";
    }
    setState(() {});
  }

  _paperOut() async {
    try {
      await NyxPrinter.paperOut(80);
    } on PlatformException catch (e) {
      _log += "paperOut error: $e\n";
    }
    setState(() {});
  }

  _printTest() async {
    try {
      var ret = await NyxPrinter.getPrinterStatus();
      if (ret != PrinterStatus.SDK_OK) {
        _log += "printer status: ${PrinterStatus.msg(ret)}\n";
        setState(() {});
        return;
      }
      await NyxPrinter.printText(
          "Receipt", PrintTextStyle(textSize: 48, align: PrintAlign.CENTER));
      await NyxPrinter.printText(
          "\nOrder No:\t${DateTime.now().millisecondsSinceEpoch}\n",
          PrintTextStyle(align: PrintAlign.CENTER));
      List<int> weights = [2, 1, 1, 1];
      List<String> row1 = ["ITEM", "QTY", "PRICE", "TOTAL"];
      List<String> row2 = ["Apple", "1", "2.00", "2.00"];
      List<String> row3 = ["Strawberry", "1", "2.00", "2.00"];
      List<String> row4 = ["Watermelon", "1", "2.00", "2.00"];
      List<String> row5 = ["Orange", "1", "2.00", "2.00"];
      List<PrintTextStyle> styles = [
        PrintTextStyle(align: PrintAlign.CENTER),
        PrintTextStyle(align: PrintAlign.CENTER),
        PrintTextStyle(align: PrintAlign.CENTER),
        PrintTextStyle(align: PrintAlign.CENTER)
      ];
      await NyxPrinter.printTableText(row1, weights, styles);
      await NyxPrinter.printTableText(row2, weights, styles);
      await NyxPrinter.printTableText(row3, weights, styles);
      await NyxPrinter.printTableText(row4, weights, styles);
      await NyxPrinter.printTableText(row5, weights, styles);
      await NyxPrinter.printText("\nOrder Price: \t\t9999.00\n",
          PrintTextStyle(align: PrintAlign.CENTER));
      await NyxPrinter.printQrCode(
          DateTime.now().millisecondsSinceEpoch.toString(), 300, 300,
          align: PrintAlign.CENTER);
      await NyxPrinter.printText("\n", PrintTextStyle());
      await NyxPrinter.printBarcode(
          DateTime.now().millisecondsSinceEpoch.toString(), 300, 150,
          textPosition: BarcodeTextPosition.TEXT_BELOW,
          align: PrintAlign.CENTER);
      await NyxPrinter.printText("\n", PrintTextStyle());
      Uint8List bytes = await loadAssetsImage('images/rabbit_black.jpg');
      await NyxPrinter.printImage(bytes, align: PrintAlign.CENTER);
      await NyxPrinter.printText(
          "\n***Print Complete***", PrintTextStyle(align: PrintAlign.CENTER));
      await NyxPrinter.printEndAutoOut();
    } on PlatformException catch (e) {
      _log += "printTest error: $e\n";
    }
    setState(() {});
  }

  _showLcdImage() async {
    try {
      var bytes = await loadAssetsImage('images/qrcode.png');
      await NyxPrinter.configLcd(LcdOpt.INIT);
      await NyxPrinter.showLcdImage(bytes);
    } on PlatformException catch (e) {
      _log += "showLcdImage error: $e\n";
    }
    setState(() {});
  }

  _configLcd(LcdOpt opt) async {
    try {
      await NyxPrinter.configLcd(LcdOpt.INIT);
      await NyxPrinter.configLcd(opt);
    } on PlatformException catch (e) {
      _log += "configLcd error: $e\n";
    }
    setState(() {});
  }

  _openCashBox() async {
    try {
      await NyxPrinter.openCashBox();
      _log += "openCashBox success \n";
    } on PlatformException catch (e) {
      _log += "openCashBox error: $e\n";
    }
    setState(() {});
  }

  Future<Uint8List> loadAssetsImage(String path) async {
    ByteData fileData = await rootBundle.load(path);
    Uint8List bytes = fileData.buffer
        .asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Printer example app'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text("Printer Version: $_printerVersion "),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text("PrinterService Version: $_serviceVersion"),
              ),
              const Divider(),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text('PaperOut'),
                    onPressed: () => _paperOut(),
                  )),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text('Printer Test'),
                    onPressed: () => _printTest(),
                  )),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: const Text('LCD Show'),
                      onPressed: () => _showLcdImage(),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: const Text('LCD Reset'),
                      onPressed: () => _configLcd(LcdOpt.RESET),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: const Text('LCD Wakeup'),
                      onPressed: () => _configLcd(LcdOpt.WAKEUP),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: const Text('LCD Sleep'),
                      onPressed: () => _configLcd(LcdOpt.SLEEP),
                    ),
                  ),
                ],
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text('Open CashBox'),
                    onPressed: () => _openCashBox(),
                  )),
              const SizedBox(
                height: 5,
              ),
              const Divider(),
              SizedBox(
                width: double.infinity,
                child: Text(
                  _log,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
