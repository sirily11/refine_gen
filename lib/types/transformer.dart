import 'package:refine_gen/generator/generator.dart';

import 'field.dart';

abstract class Transformer {
  final FormSchema inputSchema;

  Transformer({required this.inputSchema});

  List<Field> transform();
}
