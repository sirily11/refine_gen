import 'package:refine_gen/types/adapter.dart';
import 'package:refine_gen/types/drf_schema_types.dart' as drf;
import 'package:refine_gen/types/schema.dart';

import '../generator/fields/types.dart';

/// [DRFAdapter] is a [Adapter] that can be used to convert [DRFSchema]
/// to [FormSchema]
class DRFAdapter extends Adapter<drf.DRFSchema, FormSchema> {
  DRFAdapter({required List<ViewType> viewTypes}) : super(viewTypes: viewTypes);

  FieldType _mapFieldType(String fieldType) {
    switch (fieldType.toLowerCase()) {
      case 'text':
      case 'string':
      case 'field':
        return FieldType.string;
      case 'integer':
      case 'float':
        return FieldType.number;
      case 'boolean':
        return FieldType.boolean;
      case 'image upload':
        return FieldType.image;
      case 'file upload':
        return FieldType.file;
      case 'choice':
        return FieldType.choice;
      case 'datetime':
        return FieldType.datetime;
      default:
        throw Exception('Unknown field type: $fieldType');
    }
  }

  FormSchema _handleTransform(
      {required Map<String, drf.ActionItem> inputSchemaActions,
      required Map<String, drf.Field> inputSchemaFields,
      required ViewType viewType}) {
    final outputSchemaActions = <Action>[];
    inputSchemaActions.forEach((key, value) {
      final correspondingField = inputSchemaFields[key];
      late final Action action;
      if (correspondingField?.extra.relatedModel != null) {
        action = ForeignKeyAction(
          name: key,
          label: value.label,
          type: FieldType.foreignKey,
          readOnly: value.readOnly,
          required: value.required,
          relatedModel: correspondingField!.extra.relatedModel!,
        );
      } else {
        action = Action(
          name: key,
          label: value.label,
          type: _mapFieldType(value.type),
          readOnly: value.readOnly,
          required: value.required,
          maxLength: correspondingField?.validations.length?.maximum,
          defaultValue: correspondingField?.extra.extraDefault,
        );
      }
      outputSchemaActions.add(action);
    });

    return FormSchema(
      name: inputSchema.name,
      viewType: viewType,
      actions: outputSchemaActions,
    );
  }

  @override
  List<FormSchema> transform() {
    final List<FormSchema> outputs = [];
    final mapFields = <String, drf.Field>{};

    for (var field in inputSchema.fields) {
      mapFields[field.name] = field;
    }

    if (inputSchema.actions.post != null) {
      final results = viewTypes.map(
        (viewType) => _handleTransform(
          inputSchemaActions: inputSchema.actions.post!,
          inputSchemaFields: mapFields,
          viewType: viewType,
        ),
      );
      outputs.addAll(results);
    }

    return outputs;
  }
}
