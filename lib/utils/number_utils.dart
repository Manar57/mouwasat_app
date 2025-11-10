
class NumberUtils {
  static String convertToEnglishDigits(String input) {
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    const englishDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

    String output = input;
    for (int i = 0; i < arabicDigits.length; i++) {
      output = output.replaceAll(arabicDigits[i], englishDigits[i]);
    }
    return output;
  }

  static double? tryParseDouble(String value) {
    if (value.isEmpty) return null;
    final englishValue = convertToEnglishDigits(value);
    return double.tryParse(englishValue);
  }

  static int? tryParseInt(String value) {
    if (value.isEmpty) return null;
    final englishValue = convertToEnglishDigits(value);
    return int.tryParse(englishValue);
  }
}