import 'dart:io';

import 'package:jinja/jinja.dart';
import 'package:jinja/loaders.dart';
import 'package:refine_gen/adapter/drf_adapter.dart';
import 'package:refine_gen/formatter/prettier.dart';
import 'package:refine_gen/transformer/schema_field_transformer.dart';
import 'package:refine_gen/types/drf_schema_types.dart';
import 'package:refine_gen/types/types.dart';
import 'package:recase/recase.dart';
import '../types/adapter.dart';

typedef InputType = DRFSchema;
typedef OutputType = FormSchema;

/// Create a refine generator with antd form
class RefineAntdGenerator extends Generator<InputType, OutputType> {
  RefineAntdGenerator({
    required InputType inputSchema,
    Adapter<InputType, OutputType>? adapter,
    Transformer? transformer,
    Formatter? formatter,
    required List<ViewType> viewTypes,
    required String outputDir,
  }) : super(
          inputSchema: inputSchema,
          transformer: transformer ?? SchemaFieldTransformer(),
          formatter: PrettierFormatter(),
          adapter: adapter ??
              DRFAdapter(
                viewTypes: viewTypes,
              ),
          viewTypes: viewTypes,
          outputDir: outputDir,
        );

  @override
  Map<String, dynamic> renderMap({
    required List<String> fields,
    required schema,
    required List<String> selections,
    required List<String> initialValues,
  }) {
    final readOnlyMaps = schema.actions.map((e) => e.readOnly).toList();
    final prefix = _getPrefixByViewType(schema);
    final componentName =
        '${prefix}_${schema.name.replaceAll("List", "")}'.pascalCase;

    return {
      'fields': fields,
      'initialValues': initialValues,
      'selections': selections,
      'readOnlys': readOnlyMaps,
      'componentName': componentName,
      'viewType': schema.viewType
    };
  }

  @override
  String outputFileName(schema) {
    final prefix = _getPrefixByViewType(schema);
    final fileName = '${prefix}_${schema.name}'.snakeCase;

    return '$fileName.tsx';
  }

  String _getPrefixByViewType(OutputType schema) {
    String prefix;
    switch (schema.viewType) {
      case ViewType.list:
        prefix = 'list';
        break;
      case ViewType.retrieve:
        prefix = 'detail';
        break;
      case ViewType.edit:
        prefix = 'edit';
        break;
      case ViewType.create:
        prefix = 'create';
        break;
      case ViewType.delete:
        prefix = 'delete';
        break;
    }
    return prefix;
  }

  @override
  Template getTemplate(schema) {
    String templateName = '';
    switch (schema.viewType) {
      case ViewType.list:
        templateName = 'list.jinja';
        break;
      case ViewType.retrieve:
        templateName = 'detail.jinja';
        break;
      case ViewType.edit:
        templateName = 'edit.jinja';
        break;
      case ViewType.create:
        templateName = 'create.jinja';
        break;
      case ViewType.delete:
        templateName = 'delete.jinja';
        break;
    }

    var path = Directory.current.uri.resolve('templates').toFilePath();
    final environment = Environment(loader: FileSystemLoader(path: path));
    return environment.getTemplate('antd/$templateName');
  }
}
