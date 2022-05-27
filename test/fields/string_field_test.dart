import 'package:refine_gen/generator/generator.dart';
import 'package:test/test.dart';

void main() {
  group('StringField', () {
    test('Should render required is true', () {
      final result = StringField(
        name: 'name',
        label: 'label',
        readOnly: false,
        required: false,
        maxLength: null,
        defaultValue: null,
      ).render(ViewType.create);
      expect(
        result,
        equals(
            '''<Form.Item label="label" name="name" required={false}><Input /></Form.Item>'''),
      );
    });

    test('Should render required is false', () {
      final result = StringField(
        name: 'name',
        label: 'label',
        readOnly: false,
        required: true,
        maxLength: null,
        defaultValue: null,
      ).render(ViewType.create);
      expect(
        result,
        equals(
            '''<Form.Item label="label" name="name" required={true}><Input /></Form.Item>'''),
      );
    });

    test('Should render text area', () {
      final result = StringField(
        name: 'name',
        label: 'label',
        readOnly: false,
        required: false,
        maxLength: 100,
        defaultValue: null,
      ).render(ViewType.create);
      expect(
        result,
        equals(
            '''<Form.Item label="label" name="name" required={false}><Input.TextArea /></Form.Item>'''),
      );
    });
  });
}
