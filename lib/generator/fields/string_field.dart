import '../../../types/field.dart';
import './types.dart';

class StringField extends Field {
  StringField({
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
    String field = '<Input />';
    if ((maxLength ?? 0) > 50) {
      field = '<Input.TextArea />';
    }

    return '''<Form.Item label="$label" name="$name" required={${required ? 'true' : 'false'}}>$field</Form.Item>''';
  }

  @override
  String renderList() {
    return ''' <Table.Column dataIndex="$name" title="$label" render={(value) => <TextField value={value} />} />
''';
  }

  @override
  String renderEdit() {
    return renderCreate();
  }
}
