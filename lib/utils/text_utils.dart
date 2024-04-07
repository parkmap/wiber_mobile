class TextUtils {
  static String getShortenedString(
    String val, {
    int frontLength = 4,
    int rearLength = 4,
    middleString = '...',
  }) {
    if (val.isEmpty) return val;
    return val.substring(0, frontLength) +
        middleString +
        val.substring(val.length - rearLength, val.length);
  }

  static String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
