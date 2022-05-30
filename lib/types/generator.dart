import 'dart:io';

import 'package:refine_gen/types/adapter.dart';
import 'package:refine_gen/types/types.dart';
import 'package:jinja/jinja.dart';
import 'package:path/path.dart' as path;

abstract class Generator<V, T extends View> {
  final V inputSchema;
  late List<T> transformedSchema;
  final Transformer transformer;
  final Adapter<V, T> adapter;
  final environment = Environment();
  final String outputDir;
  final List<ViewType> viewTypes;

  Generator({
    required this.inputSchema,
    required this.transformer,
    required this.adapter,
    required this.viewTypes,
    this.outputDir = 'dist',
  }) {
    // Check if output directory exists
    if (!Directory(outputDir).existsSync()) {
      Directory(outputDir).createSync(recursive: true);
    }
  }

  void _transform() {
    adapter.read(inputSchema);
    transformedSchema = adapter.transform();
  }

  // get jinja template
  Template getTemplate(T schema);

  // get jinja render context
  Map<String, dynamic> renderMap(
      {required List<String> fields,
      required T schema,
      required List<String> selections});

  // get output file name based on the schema
  String outputFileName(T schema);

  /// render code
  void render() {
    _transform();

    for (var schema in transformedSchema) {
      final readTemplate = getTemplate(schema);
      transformer.read(schema);
      final fields = transformer.transform();
      final List<String> renderedFields = [];
      final List<String> renderedSelections = [];
      for (var field in fields) {
        final renderedString = field.render(schema.viewType);
        if (field is ModelField) {
          final renderedSelection = field.renderSelection(schema.viewType);
          renderedSelections.add(renderedSelection);
        }
        if (renderedString != null) {
          renderedFields.add(renderedString);
        }
      }
      final result = readTemplate.render(renderMap(
        fields: renderedFields,
        schema: schema,
        selections: renderedSelections,
      ));

      final outputFilename = outputFileName(schema);
      final outputFile = File(path.join(outputDir, outputFilename));
      print('Generating $outputFilename');
      outputFile.writeAsStringSync(result);
    }
  }
}
