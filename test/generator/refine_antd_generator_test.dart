import 'package:refine_gen/generator/refine_antd_generator.dart';
import 'package:refine_gen/types/drf_schema_types.dart' as drf;
import 'package:refine_gen/types/schema.dart';
import 'package:test/test.dart';

void main() {
  final inputSchema = drf.DRFSchema(
    name: 'test',
    fields: [
      drf.Field(
        name: 'test',
        validations: drf.Validations(
          length: drf.Length(maximum: 128),
        ),
        extra: drf.Extra(extraDefault: 'hello'),
        widget: 'number',
        label: 'test',
        readonly: false,
        required: false,
        translated: false,
      ),
      drf.Field(
        name: 'name',
        validations: drf.Validations(),
        extra: drf.Extra(
          extraDefault: 'hello',
          choices: [drf.Choice(label: 'hello', value: 'world')],
        ),
        widget: 'integer',
        label: 'test',
        readonly: false,
        required: false,
        translated: false,
      ),
      drf.Field(
        name: 'description',
        validations: drf.Validations(),
        extra: drf.Extra(),
        widget: 'text',
        label: 'test',
        readonly: false,
        required: false,
        translated: false,
      ),
    ],
    actions: drf.Actions(post: {
      'test': drf.ActionItem(
        label: 'test',
        type: 'string',
        readOnly: true,
        required: true,
      ),
      'name': drf.ActionItem(
        label: 'name',
        type: 'integer',
        readOnly: false,
        required: true,
      ),
      'description': drf.ActionItem(
        label: 'description',
        type: 'image upload',
        readOnly: false,
        required: true,
      ),
    }),
    conditionalFormatting: drf.ConditionalFormatting(),
    renders: [],
    saveTwice: true,
    searchEnabled: true,
    description: '',
    parses: [],
  );

  group('Given a refine antd generator', () {
    test('generate file name', () {
      final generator = RefineAntdGenerator(
          inputSchema: inputSchema,
          viewTypes: [ViewType.create],
          outputDir: 'dist');
      final result = generator.outputFileName(
        FormSchema(
          viewType: ViewType.create,
          name: 'hello',
          actions: [],
        ),
      );
      expect(result, 'create_hello.tsx');
    });

    test('generate file name', () {
      final generator = RefineAntdGenerator(
          inputSchema: inputSchema,
          viewTypes: [ViewType.create],
          outputDir: 'dist');
      final result = generator.outputFileName(
        FormSchema(
          viewType: ViewType.delete,
          name: 'hello',
          actions: [],
        ),
      );
      expect(result, 'delete_hello.tsx');
    });

    test('generate file name', () {
      final generator = RefineAntdGenerator(
          inputSchema: inputSchema,
          viewTypes: [ViewType.create],
          outputDir: 'dist');
      final result = generator.outputFileName(
        FormSchema(
          viewType: ViewType.edit,
          name: 'hello',
          actions: [],
        ),
      );
      expect(result, 'edit_hello.tsx');
    });

    test('generate file name', () {
      final generator = RefineAntdGenerator(
          inputSchema: inputSchema,
          viewTypes: [ViewType.create],
          outputDir: 'dist');
      final result = generator.outputFileName(
        FormSchema(
          viewType: ViewType.list,
          name: 'hello',
          actions: [],
        ),
      );
      expect(result, 'list_hello.tsx');
    });

    test('generate file name', () {
      final generator = RefineAntdGenerator(
        inputSchema: inputSchema,
        viewTypes: [ViewType.create],
        outputDir: 'dist',
      );
      final result = generator.outputFileName(
        FormSchema(
          viewType: ViewType.retrieve,
          name: 'hello',
          actions: [],
        ),
      );
      expect(result, 'detail_hello.tsx');
    });
  });
}
