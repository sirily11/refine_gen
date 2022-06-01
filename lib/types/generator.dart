import 'dart:io';

import 'package:refine_gen/types/adapter.dart';
import 'package:refine_gen/types/formatter.dart';
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
  final Formatter formatter;

  Generator({
    required this.inputSchema,
    required this.transformer,
    required this.adapter,
    required this.viewTypes,
    required this.formatter,
    this.outputDir = 'dist',
  }) {
    // Check if output directory exists
    if (!Directory(outputDir).existsSync()) {
      Directory(outputDir).createSync(recursive: true);
    }

    formatter.initialize();
  }

  void _transform() {
    adapter.read(inputSchema);
    transformedSchema = adapter.transform();
  }

  // get jinja template
  Template getTemplate(T schema);

  // get jinja render context
  Map<String, dynamic> renderMap({
    required List<String> fields,
    required T schema,
    required List<String> selections,
    required List<String> initialValues,
  });

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
      final List<String> renderedInitialValues = [];

      for (var field in fields) {
        final renderedString = field.render(schema.viewType);
        if (field is ModelField) {
          final renderedSelection = field.renderSelection(schema.viewType);
          renderedSelections.add(renderedSelection);
        }
        if (renderedString != null) {
          renderedFields.add(renderedString);
        }

        final renderedInitialValue = field.renderInitialValue(schema.viewType);
        if (renderedInitialValue != null) {
          renderedInitialValues.add(renderedInitialValue);
        }
      }
      final result = readTemplate.render(renderMap(
        fields: renderedFields,
        schema: schema,
        selections: renderedSelections,
        initialValues: renderedInitialValues,
      ));

      final outputFilename = outputFileName(schema);
      final outputFile = File(path.join(outputDir, outputFilename));
      print('Generating $outputFilename');
      outputFile.writeAsStringSync(result);
      // format the file
      final formattedResult = formatter.format(
        code: result,
        fileName: outputFile.path,
      );
      if (formattedResult != null) {
        outputFile.writeAsStringSync(formattedResult);
      }
    }
  }
}
