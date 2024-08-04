import 'package:flutter_test/flutter_test.dart';
import 'package:nyx_printer/nyx_printer.dart';
import 'package:nyx_printer/nyx_printer_platform_interface.dart';
import 'package:nyx_printer/nyx_printer_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNyxPrinterPlatform
    with MockPlatformInterfaceMixin
    implements NyxPrinterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final NyxPrinterPlatform initialPlatform = NyxPrinterPlatform.instance;

  test('$MethodChannelNyxPrinter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNyxPrinter>());
  });

  test('getPlatformVersion', () async {
    NyxPrinter nyxPrinterPlugin = NyxPrinter();
    MockNyxPrinterPlatform fakePlatform = MockNyxPrinterPlatform();
    NyxPrinterPlatform.instance = fakePlatform;

    expect(await nyxPrinterPlugin.getPlatformVersion(), '42');
  });
}
