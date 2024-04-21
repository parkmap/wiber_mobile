class TextUtils {
  static String getShortenedString({
    String val = '',
    int length = 12,
    middleString = '...',
  }) {
    if (val.isEmpty) return val;

    if (val.length <= length) return val;

    return val.substring(0, length) + middleString;
  }

  static String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
