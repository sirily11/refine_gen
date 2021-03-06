import 'dart:convert';

import '../../../types/field.dart';
import '../../types/schema.dart';
import './types.dart';

class ChoiceField extends Field {
  final List<Choice> choices;

  ChoiceField({
    required String name,
    required String label,
    required bool required,
    required bool readOnly,
    required int? maxLength,
    required String? defaultValue,
    required this.choices,
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
    final choicesValue =
        JsonEncoder().convert(choices.map((e) => e.toJson()).toList());
    return '''<Form.Item label="$label" name="$name" required={${required ? 'true' : 'false'}}>
<Select options={$choicesValue}/>
</Form.Item>''';
  }

  @override
  String renderList() {
    return ''' <Table.Column dataIndex="$name" title="$label" render={(value) => <TagField value={value} />} />
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
