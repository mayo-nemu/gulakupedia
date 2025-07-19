String doubleToString(double value) {
  // Convert the double to a string with a maximum of two decimal places.
  String strValue = value.toStringAsFixed(2);

  // Remove trailing zeros and the decimal point if it results in an integer.
  if (strValue.contains('.')) {
    strValue = strValue.replaceAll(RegExp(r'0*$'), ''); // Remove trailing zeros
    if (strValue.endsWith('.')) {
      strValue = strValue.substring(
        0,
        strValue.length - 1,
      ); // Remove trailing dot if no fractional part left
    }
  }
  return strValue;
}
