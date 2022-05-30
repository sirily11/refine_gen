import 'dart:io';

import '../types/types.dart';

class PrettierFormatter extends Formatter {
  bool hasInitialized = false;

  bool _check() {
    if (Platform.isWindows) {
      final result = Process.runSync('where', ['prettier.cmd']);
      if (result.exitCode != 0) {
        print('Prettier is not installed. Please install it first.');
        return false;
      }
    } else {
      final result = Process.runSync('which', ['prettier']);
      if (result.exitCode != 0) {
        print('Prettier is not installed. Please install it first.');
        return false;
      }
    }
    return true;
  }

  @override
  void initialize() {
    final result = _check();
    hasInitialized = result;
  }

  @override
  String? format({required String fileName, required String code}) {
    // use prettier to format the code
    print('Formatting $fileName');
    Process.runSync('prettier', [fileName, '--write']);
    return null;
  }
}
