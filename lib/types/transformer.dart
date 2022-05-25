import 'package:refine_gen/generator/generator.dart';

import 'field.dart';

abstract class Transformer {
  final InputSchema inputSchema;

  Transformer({required this.inputSchema});

  List<Field> transform();
}
