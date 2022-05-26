import 'dart:io';

import 'package:refine_gen/types/adapter.dart';
import 'package:refine_gen/types/types.dart';
import 'package:jinja/jinja.dart';

abstract class Generator<V, T> {
  final V inputSchema;
  late List<T> transformedSchema;
  final Transformer transformer;
  final Adapter<V, T> adapter;
  final _environment = Environment();

  Generator({
    required this.inputSchema,
    required this.transformer,
    required this.adapter,
  });

  void _transform() {
    adapter.read(inputSchema);
    transformedSchema = adapter.transform();
  }

  String renderTemplate(T schema);

  Map<String, dynamic> renderMap({required List<String> fields});

  String outputFileName(T schema);

  /// render code
  void render() {
    _transform();

    for (var schema in transformedSchema) {
      final readTemplate = _environment.fromString(renderTemplate(schema));
      transformer.read(schema);
      final fields = transformer.transform();
      final List<String> renderedFields = [];
      for (var field in fields) {
        renderedFields.add(field.render());
      }
      final result = readTemplate.renderMap(renderMap(fields: renderedFields));
      final outputFilename = outputFileName(schema);
      final outputFile = File(outputFilename);
      print('Generating $outputFilename');
      outputFile.writeAsStringSync(result);
    }
  }
}
