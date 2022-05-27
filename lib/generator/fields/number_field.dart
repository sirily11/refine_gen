import '../../../types/field.dart';
import './types.dart';

class NumberField extends Field {
  NumberField({
    required String name,
    required String label,
    required bool required,
    required bool readOnly,
    required int? maxLength,
    required String? defaultValue,
  }) : super(
          name: name,
          type: FieldType.string,
          label: label,
          required: required,
          readOnly: readOnly,
          maxLength: maxLength,
          defaultValue: defaultValue,
        );

  @override
  String renderCreate() {
    return '''<Form.Item label="$label" name="$name" required={${required ? 'true' : 'false'}}><Input /></Form.Item>''';
  }
}
