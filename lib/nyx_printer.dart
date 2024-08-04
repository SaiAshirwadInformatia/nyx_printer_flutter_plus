
import 'nyx_printer_platform_interface.dart';

class NyxPrinter {
  Future<String?> getPlatformVersion() {
    return NyxPrinterPlatform.instance.getPlatformVersion();
  }
}
