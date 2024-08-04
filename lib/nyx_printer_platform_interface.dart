import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'nyx_printer_method_channel.dart';

abstract class NyxPrinterPlatform extends PlatformInterface {
  /// Constructs a NyxPrinterPlatform.
  NyxPrinterPlatform() : super(token: _token);

  static final Object _token = Object();

  static NyxPrinterPlatform _instance = MethodChannelNyxPrinter();

  /// The default instance of [NyxPrinterPlatform] to use.
  ///
  /// Defaults to [MethodChannelNyxPrinter].
  static NyxPrinterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NyxPrinterPlatform] when
  /// they register themselves.
  static set instance(NyxPrinterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
