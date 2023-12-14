import 'dart:io';

/// This certificate necessory for HTTP clint hand shake.
/// Elese sometime APIs Will not work
class HttpCertificate extends HttpOverrides {
  static void call() => HttpOverrides.global = HttpCertificate();

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        // print([cert, host, port]);
        return true;
      };
  }
}
