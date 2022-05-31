import '../../../types/field.dart';
import './types.dart';

class ImageField extends Field {
  ImageField({
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
    return '''<Form.Item label="$label" name={"$name"} required>
          <Form.Item
            name="$name"
            valuePropName="file"
            getValueFromEvent={getValueFromEvent}
            noStyle
          >
            <Upload.Dragger
              name="$name"
              accept="image/png, image/gif, image/jpeg"
              multiple={false}
              maxCount={1}
            >
              <p className="ant-upload-drag-icon">Drag image here</p>
            </Upload.Dragger>
          </Form.Item>
        </Form.Item>''';
  }

  @override
  String renderList() {
    return ''' <Table.Column dataIndex="$name" title="$label" render={(value) =>  <ImageField value={value} width={300} />} />
''';
  }

  @override
  String renderDetail() {
    return '''<Title level={5}>$label</Title><ImageField value={record?.$name} width={"50%"}/>''';
  }

  @override
  String renderEdit() {
    return renderCreate();
  }
}
