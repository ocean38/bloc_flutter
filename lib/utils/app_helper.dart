class AppHelper {
  static bool isNullOrEmpty(value) {
    if (value == null) {
      return true;
    } else if (value is List || value is String) {
      return value.isEmpty;
    }
    return value == '';
  }
}
