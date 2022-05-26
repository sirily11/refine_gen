import 'package:refine_gen/generator/generator.dart';
import 'package:refine_gen/types/types.dart';

abstract class Generator {
  late List<Field> fields;
  final List<FormSchema> inputSchema;
  final Transformer transformer;

  Generator({required this.inputSchema, required this.transformer});

  void transform() {
    fields = transformer.transform();
  }

  /// render code
  String render() {
    transform();
    var output = '';
    for (var field in fields) {
      output += field.render();
    }
    return output;
  }
}
