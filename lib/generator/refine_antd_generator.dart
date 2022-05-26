import 'dart:io';

import 'package:refine_gen/adapter/drf_adapter.dart';
import 'package:refine_gen/transformer/schema_field_transformer.dart';
import 'package:refine_gen/types/drf_schema_types.dart';
import 'package:refine_gen/types/types.dart';

typedef InputType = DRFSchema;
typedef OutputType = FormSchema;

/// Create a refine generator with antd form
class RefineAntdGenerator extends Generator<InputType, OutputType> {
  RefineAntdGenerator({
    required InputType inputSchema,
  }) : super(
          inputSchema: inputSchema,
          transformer: SchemaFieldTransformer(),
          adapter: DRFAdapter(),
        );

  @override
  Map<String, dynamic> renderMap({required List<String> fields}) {
    // TODO: implement renderMap
    throw UnimplementedError();
  }

  @override
  String outputFileName(schema) {
    String prefix = '';
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

    return '${prefix}_${schema.name}.tsx';
  }

  @override
  String renderTemplate(schema) {
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

    return File('templates/antd/$templateName').readAsStringSync();
  }
}
