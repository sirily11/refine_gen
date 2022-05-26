import '../../../types/field.dart';
import './types.dart';

class ForeignKeyField extends ModelField {
  ForeignKeyField(
      {required String name,
      required String label,
      required bool required,
      required bool readOnly,
      required int? maxLength,
      required String? defaultValue,
      required String relatedModel})
      : super(
            name: name,
            label: label,
            required: required,
            readOnly: readOnly,
            maxLength: maxLength,
            defaultValue: defaultValue,
            foreignKey: relatedModel);

  @override
  String renderCreate() {
    return ''' <Form.Item label="$label" name={"$name"}>
          <Select {...$selectionName } />
        </Form.Item>''';
  }
}
