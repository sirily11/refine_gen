import 'package:refine_gen/generator/generator.dart';
import 'package:refine_gen/types/types.dart';

Field _mapFields(
  FieldType type, {
  required String name,
  required String label,
  required bool required,
  required bool readOnly,
  required int? maxLength,
  required String? defaultValue,
  required String? relatedModel,
}) {
  switch (type) {
    case FieldType.string:
      return StringField(
        label: label,
        name: name,
        required: required,
        readOnly: readOnly,
        maxLength: maxLength,
        defaultValue: defaultValue,
      );
    case FieldType.number:
      return NumberField(
        label: label,
        name: name,
        required: required,
        readOnly: readOnly,
        maxLength: maxLength,
        defaultValue: defaultValue,
      );
    case FieldType.datetime:
      return DatetimeField(
        label: label,
        name: name,
        required: required,
        readOnly: readOnly,
        maxLength: maxLength,
        defaultValue: defaultValue,
      );
    case FieldType.choice:
      return ChoiceField(
        label: label,
        name: name,
        required: required,
        readOnly: readOnly,
        maxLength: maxLength,
        defaultValue: defaultValue,
      );
    case FieldType.foreignKey:
      return ForeignKeyField(
        label: label,
        name: name,
        required: required,
        readOnly: readOnly,
        maxLength: maxLength,
        defaultValue: defaultValue,
        relatedModel: relatedModel!,
      );
    case FieldType.image:
      return ImageField(
        name: name,
        label: label,
        required: required,
        readOnly: readOnly,
        maxLength: maxLength,
        defaultValue: defaultValue,
      );
    default:
      throw Exception('Unsupported field type: $type');
  }
}

class SchemaFieldTransformer extends Transformer {
  SchemaFieldTransformer();

  @override
  List<Field> transform() {
    final fields = <Field>[];
    for (final action in inputSchema.actions) {
      late final Field field;
      if (action is ForeignKeyAction) {
        field = _mapFields(
          action.type,
          name: action.name,
          label: action.label,
          readOnly: action.readOnly,
          required: action.required,
          maxLength: action.maxLength,
          defaultValue: action.defaultValue,
          relatedModel: action.relatedModel,
        );
      } else {
        field = _mapFields(
          action.type,
          name: action.name,
          label: action.label,
          readOnly: action.readOnly,
          required: action.required,
          maxLength: action.maxLength,
          defaultValue: action.defaultValue,
          relatedModel: null,
        );
      }
      fields.add(field);
    }

    return fields;
  }
}
