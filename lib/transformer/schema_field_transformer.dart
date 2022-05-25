import 'package:refine_gen/generator/generator.dart';
import 'package:refine_gen/types/types.dart';

Field _mapFields(FieldType type,
    {required String name,
    required String label,
    required bool required,
    required bool readOnly}) {
  switch (type) {
    case FieldType.string:
      return StringField(
          label: label, name: name, required: required, readOnly: readOnly);
    case FieldType.interger:
      return StringField(
          name: name, label: label, required: required, readOnly: readOnly);
    case FieldType.image:
      return StringField(
          name: name, label: label, required: required, readOnly: readOnly);
    case FieldType.datetime:
      return StringField(
          name: name, label: label, required: required, readOnly: readOnly);
  }
}

class SchemaFieldTransformer implements Transformer {
  @override
  final InputSchema inputSchema;

  SchemaFieldTransformer({required this.inputSchema});

  @override
  List<Field> transform() {
    final fields = <Field>[];
    for (final action in inputSchema.actions) {
      final field = _mapFields(
        action.type,
        name: action.name,
        label: action.label,
        readOnly: action.readOnly,
        required: action.required,
      );

      fields.add(field);
    }

    return fields;
  }
}
