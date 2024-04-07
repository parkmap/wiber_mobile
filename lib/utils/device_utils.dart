//
import 'package:flutter/material.dart';

/// Helper class for device related operations.
///
class DeviceUtils {
  ///
  /// hides the keyboard if its already open
  ///
  static void hideKeyboard(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
