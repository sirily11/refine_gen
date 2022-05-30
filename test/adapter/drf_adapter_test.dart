import 'package:refine_gen/adapter/drf_adapter.dart';
import 'package:refine_gen/generator/fields/types.dart';
import 'package:refine_gen/types/drf_schema_types.dart' as drf;
import 'package:refine_gen/types/types.dart';
import 'package:test/test.dart';

void main() {
  group('Given a drf adapter', () {
    test('Basic convert', () {
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
            extra: drf.Extra(extraDefault: 'hello'),
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

      final adapter = DRFAdapter(viewTypes: [
        ViewType.create,
        ViewType.delete,
        ViewType.edit,
        ViewType.list
      ]);
      adapter.read(inputSchema);

      final results = adapter.transform();

      expect(results.length, 4);
      final createSchema = results[0];

      expect(createSchema.name, 'test');
      expect(createSchema.actions.length, 3);
      expect(createSchema.actions[0].name, 'test');
      expect(createSchema.actions[0].label, 'test');
      expect(createSchema.actions[0].type, FieldType.string);
      expect(createSchema.actions[0].readOnly, true);
      expect(createSchema.actions[0].required, true);

      expect(createSchema.actions[1].name, 'name');
      expect(createSchema.actions[1].label, 'name');
      expect(createSchema.actions[1].type, FieldType.number);
      expect(createSchema.actions[1].readOnly, false);
      expect(createSchema.actions[1].required, true);

      expect(createSchema.actions[2].name, 'description');
      expect(createSchema.actions[2].label, 'description');
      expect(createSchema.actions[2].type, FieldType.image);
      expect(createSchema.actions[2].readOnly, false);
      expect(createSchema.actions[2].required, true);

      expect(createSchema.viewType, ViewType.create);
    });

    test('Convert with related model', () {
      final inputSchema = drf.DRFSchema(
        name: 'test',
        fields: [
          drf.Field(
            name: 'test',
            validations: drf.Validations(
              length: drf.Length(maximum: 128),
            ),
            extra: drf.Extra(extraDefault: 'hello', relatedModel: 'test'),
            widget: 'foreignkey',
            label: 'test',
            readonly: false,
            required: false,
            translated: false,
          ),
        ],
        actions: drf.Actions(post: {
          'test': drf.ActionItem(
            label: 'test',
            type: 'field',
            readOnly: true,
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

      final adapter = DRFAdapter(viewTypes: [
        ViewType.create,
      ]);
      adapter.read(inputSchema);
      final outputSchema = adapter.transform()[0];

      expect(outputSchema.name, 'test');
      expect(outputSchema.actions.length, 1);
      expect(outputSchema.actions[0].name, 'test');
      expect(outputSchema.actions[0].label, 'test');
      expect(outputSchema.actions[0].type, FieldType.foreignKey);
      expect(outputSchema.actions[0].readOnly, true);
      expect(outputSchema.actions[0].required, true);
      expect(outputSchema.actions[0] is ForeignKeyAction, true);
      expect(
          (outputSchema.actions[0] as ForeignKeyAction).relatedModel, 'test');
    });
  });
}
