import '../../../types/field.dart';
import './types.dart';

class StringField extends Field {
  StringField(
      {required String name,
      required String label,
      required bool required,
      required bool readOnly})
      : super(
          name: name,
          type: FieldType.string,
          label: label,
          required: required,
          readOnly: readOnly,
        );

  @override
  String render() {
    return '''<Form.Item label="$label" name="$name"><Input /></Form.Item>''';
  }
}
