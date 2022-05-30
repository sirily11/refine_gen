import 'package:refine_gen/refine_gen.dart';
import 'package:test/test.dart';

void main() {
  group('Given a choice field', () {
    test('Should render without error', () {
      final result = ChoiceField(
        name: 'Hello',
        label: 'World',
        required: true,
        readOnly: false,
        maxLength: null,
        defaultValue: null,
        choices: [Choice(label: 'Hello', value: 'World')],
      ).render(ViewType.create);

      expect(result,
          equals('''<Form.Item label="World" name="Hello" required={true}>
<Select options={[{"label":"Hello","value":"World"}]}/>
</Form.Item>'''));
    });

    test('Should render without error', () {
      final result = ChoiceField(
        name: 'Hello',
        label: 'World',
        required: true,
        readOnly: false,
        maxLength: null,
        defaultValue: null,
        choices: [
          Choice(label: 'Hello', value: 'World'),
          Choice(label: 'Hello2', value: 'World2')
        ],
      ).render(ViewType.create);

      expect(result,
          equals('''<Form.Item label="World" name="Hello" required={true}>
<Select options={[{"label":"Hello","value":"World"},{"label":"Hello2","value":"World2"}]}/>
</Form.Item>'''));
    });

    test('Should render without error', () {
      final result = ChoiceField(
        name: 'Hello',
        label: 'World',
        required: true,
        readOnly: false,
        maxLength: null,
        defaultValue: null,
        choices: [],
      ).render(ViewType.create);

      expect(result,
          equals('''<Form.Item label="World" name="Hello" required={true}>
<Select options={[]}/>
</Form.Item>'''));
    });
  });
}
