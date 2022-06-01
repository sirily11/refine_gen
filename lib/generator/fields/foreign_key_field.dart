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
    return ''' <Form.Item label="$label" name={"$name"} required={${required ? 'true' : 'false'}}>
          <Select {...$selectionName } />
        </Form.Item>''';
  }

  @override
  String renderList() {
    return ''' <Table.Column dataIndex="$name" title="$label" render={(value) => <TagField value={value} />} />
''';
  }

  @override
  String renderDetail() {
    return '''<Title level={5}>$label</Title><Text>{$selectionName?.data?.title}</Text>''';
  }

  @override
  String renderEdit() {
    return renderCreate();
  }
}
