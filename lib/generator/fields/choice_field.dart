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
}
