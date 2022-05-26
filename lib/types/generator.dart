import 'package:refine_gen/types/adapter.dart';
import 'package:refine_gen/types/types.dart';

abstract class Generator<V, T> {
  late List<Field> fields;
  final V inputSchema;
  final Transformer transformer;
  final Adapter<V, T> adapter;

  Generator({
    required this.inputSchema,
    required this.transformer,
    required this.adapter,
  });

  void transform() {
    adapter.read(inputSchema);
    final transformedSchema = adapter.transform();

    fields = [];

    for (final schema in transformedSchema) {
      transformer.read(schema);
      fields.addAll(transformer.transform());
    }
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
