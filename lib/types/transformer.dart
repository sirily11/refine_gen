import 'package:refine_gen/generator/generator.dart';

import 'field.dart';

abstract class Transformer<T> {
  late T inputSchema;

  Transformer();

  /// read inputSchema
  void read(T inputSchema) {
    this.inputSchema = inputSchema;
  }

  List<Field> transform();
}
