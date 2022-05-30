import 'package:refine_gen/generator/fields/types.dart';
import 'package:refine_gen/transformer/schema_field_transformer.dart';
import 'package:refine_gen/types/schema.dart';
import 'package:test/test.dart';

void main() {
  group('Test schema field transformer', () {
    test('Returns without problem', () {
      final inputSchema =
          FormSchema(viewType: ViewType.create, name: 'Test', actions: [
        Action(
          type: FieldType.string,
          name: 'name',
          label: 'Name',
          required: true,
          defaultValue: '',
          maxLength: 10,
          readOnly: false,
        ),
        Action(
          type: FieldType.string,
          name: 'email',
          label: 'Email',
          required: true,
          defaultValue: '',
          maxLength: 10,
          readOnly: false,
        ),
        Action(
          type: FieldType.string,
          name: 'password',
          label: 'Password',
          required: true,
          defaultValue: '',
          maxLength: 10,
          readOnly: false,
        ),
      ]);

      final transformer = SchemaFieldTransformer();
      transformer.read(inputSchema);

      final fields = transformer.transform();
      expect(fields.length, equals(3));
      expect(fields[0].name, equals('name'));
      expect(fields[0].label, equals('Name'));
      expect(fields[0].type, equals(FieldType.string));
      expect(fields[0].required, equals(true));
      expect(fields[0].readOnly, equals(false));

      expect(fields[1].name, equals('email'));
      expect(fields[1].label, equals('Email'));
      expect(fields[1].type, equals(FieldType.string));
      expect(fields[1].required, equals(true));
      expect(fields[1].readOnly, equals(false));

      expect(fields[2].name, equals('password'));
      expect(fields[2].label, equals('Password'));
      expect(fields[2].type, equals(FieldType.string));
      expect(fields[2].required, equals(true));
      expect(fields[2].readOnly, equals(false));
    });
  });
}
