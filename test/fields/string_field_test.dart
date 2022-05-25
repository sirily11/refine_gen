import 'package:refine_gen/generator/generator.dart';
import 'package:test/test.dart';

void main() {
  group('StringField', () {
    test('render', () {
      final result = StringField(
              name: 'name', label: 'label', readOnly: false, required: false)
          .render();
      expect(
        result,
        equals(
            '''<Form.Item label="label" name="name"><Input /></Form.Item>'''),
      );
    });
  });
}
