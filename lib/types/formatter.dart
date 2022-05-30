abstract class Formatter {
  void initialize();

  // Format the given code by [fileName] or [code]
  String? format({required String fileName, required String code});
}
