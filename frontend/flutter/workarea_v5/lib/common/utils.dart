import 'package:crypto/crypto.dart';

class Utils {
  static String generateSHA256(String input) {
    return sha256.convert(input.codeUnits).toString();
  }
}
