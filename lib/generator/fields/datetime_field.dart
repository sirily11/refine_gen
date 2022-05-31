import '../../../types/field.dart';
import './types.dart';

class DatetimeField extends Field {
  DatetimeField({
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
    return '''<Form.Item label="$label" name="$name" required={${required ? 'true' : 'false'}}><DatePicker /></Form.Item>''';
  }

  @override
  String renderList() {
    return ''' <Table.Column dataIndex="$name" title="$label" render={(value) => <DateField format={"LLL"} value={value} />} />
''';
  }

  @override
  String renderDetail() {
    return '''<Title level={5}>$label</Title><Text>{record?.$name}</Text>''';
  }

  @override
  String renderEdit() {
    return renderCreate();
  }
}
