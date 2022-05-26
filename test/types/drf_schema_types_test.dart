import 'package:refine_gen/types/drf_schema_types.dart';
import 'package:test/test.dart';

void main() {
  group('Given a drf schema', () {
    final Map<String, dynamic> schema = {
      'name': 'Plane List',
      'description': '',
      'renders': ['application/json', 'text/html'],
      'parses': ['multipart/form-data'],
      'actions': {
        'POST': {
          'id': {
            'type': 'integer',
            'required': false,
            'read_only': true,
            'label': 'ID'
          },
          'name': {
            'type': 'string',
            'required': false,
            'read_only': false,
            'label': 'Name',
            'max_length': 128
          },
          'description': {
            'type': 'string',
            'required': true,
            'read_only': false,
            'label': 'Description'
          },
          'image': {
            'type': 'image upload',
            'required': true,
            'read_only': false,
            'label': 'Image',
            'max_length': 100
          },
          'created_time': {
            'type': 'datetime',
            'required': false,
            'read_only': true,
            'label': 'Created time'
          },
          'updated_time': {
            'type': 'datetime',
            'required': false,
            'read_only': true,
            'label': 'Updated time'
          },
        },
      },
      'fields': [
        {
          'label': 'ID',
          'readonly': true,
          'extra': {},
          'name': 'id',
          'widget': 'number',
          'required': false,
          'translated': false,
          'validations': {}
        },
        {
          'label': 'name',
          'readonly': false,
          'extra': {'default': 'a'},
          'name': 'name',
          'widget': 'text',
          'required': false,
          'translated': false,
          'validations': {
            'length': {'maximum': 128}
          }
        },
        {
          'label': 'description',
          'readonly': false,
          'extra': {},
          'name': 'description',
          'widget': 'text',
          'required': true,
          'translated': false,
          'validations': {'presence': true}
        },
        {
          'label': 'image',
          'readonly': false,
          'extra': {},
          'name': 'image',
          'widget': 'text',
          'required': true,
          'translated': false,
          'validations': {
            'presence': true,
            'length': {'maximum': 100}
          }
        },
        {
          'label': 'created time',
          'readonly': true,
          'extra': {},
          'name': 'created_time',
          'widget': 'datetime',
          'required': false,
          'translated': false,
          'validations': {}
        },
        {
          'label': 'updated time',
          'readonly': true,
          'extra': {},
          'name': 'updated_time',
          'widget': 'datetime',
          'required': false,
          'translated': false,
          'validations': {}
        }
      ],
      'save_twice': false,
      'search_enabled': true,
      'conditional_formatting': {}
    };

    test('Convert to dart object', () {
      final result = DRFSchema.fromJson(schema);
      expect(result.name, equals('Plane List'));
      expect(result.description, equals(''));
      expect(result.renders, equals(['application/json', 'text/html']));
      expect(result.parses, equals(['multipart/form-data']));

      expect(result.actions.post?['id']?.type, equals('integer'));
      expect(result.actions.post?['id']?.required, equals(false));
      expect(result.actions.post?['id']?.readOnly, equals(true));
      expect(result.actions.post?['id']?.label, equals('ID'));
      expect(result.actions.post?['name']?.type, equals('string'));
      expect(result.actions.post?['name']?.required, equals(false));
      expect(result.actions.post?['name']?.readOnly, equals(false));
      expect(result.actions.post?['name']?.label, equals('Name'));
      expect(result.actions.post?['name']?.maxLength, equals(128));
      expect(result.actions.post?['description']?.type, equals('string'));
      expect(result.actions.post?['description']?.required, equals(true));
      expect(result.actions.post?['description']?.readOnly, equals(false));
      expect(result.actions.post?['description']?.label, equals('Description'));
      expect(result.actions.post?['image']?.type, equals('image upload'));
      expect(result.actions.post?['image']?.required, equals(true));
      expect(result.actions.post?['image']?.readOnly, equals(false));
      expect(result.actions.post?['image']?.label, equals('Image'));
      expect(result.actions.post?['image']?.maxLength, equals(100));
      expect(result.actions.post?['created_time']?.type, equals('datetime'));
      expect(result.actions.post?['created_time']?.required, equals(false));
      expect(result.actions.post?['created_time']?.readOnly, equals(true));
      expect(
          result.actions.post?['created_time']?.label, equals('Created time'));
      expect(result.actions.post?['updated_time']?.type, equals('datetime'));
      expect(result.actions.post?['updated_time']?.required, equals(false));
      expect(result.actions.post?['updated_time']?.readOnly, equals(true));
      expect(
          result.actions.post?['updated_time']?.label, equals('Updated time'));

      expect(result.fields.length, equals(6));
      expect(result.fields[0].label, equals('ID'));
      expect(result.fields[0].readonly, equals(true));
      expect(result.fields[0].extra.extraDefault, equals(null));
      expect(result.fields[0].name, equals('id'));
      expect(result.fields[0].widget, equals('number'));
      expect(result.fields[0].required, equals(false));
      expect(result.fields[0].translated, equals(false));
      expect(result.fields[0].validations.length, equals(null));

      expect(result.fields[1].label, equals('name'));
      expect(result.fields[1].readonly, equals(false));
      expect(result.fields[1].extra.extraDefault, equals('a'));
      expect(result.fields[1].name, equals('name'));
      expect(result.fields[1].widget, equals('text'));
      expect(result.fields[1].required, equals(false));
      expect(result.fields[1].translated, equals(false));
      expect(
          result.fields[1].validations.toJson(),
          equals({
            'length': {'maximum': 128},
            'presence': null
          }));

      expect(result.fields[2].label, equals('description'));
      expect(result.fields[2].readonly, equals(false));
      expect(result.fields[2].extra.extraDefault, equals(null));
      expect(result.fields[2].name, equals('description'));
      expect(result.fields[2].widget, equals('text'));
      expect(result.fields[2].required, equals(true));
      expect(result.fields[2].translated, equals(false));
      expect(result.fields[2].validations.length, equals(null));
      expect(result.fields[2].validations.presence, equals(true));

      expect(result.fields[3].label, equals('image'));
      expect(result.fields[3].readonly, equals(false));
      expect(result.fields[3].extra.extraDefault, equals(null));
      expect(result.fields[3].name, equals('image'));
      expect(result.fields[3].widget, equals('text'));
      expect(result.fields[3].required, equals(true));
      expect(result.fields[3].translated, equals(false));
      expect(result.fields[3].validations.length?.maximum, equals(100));
      expect(result.fields[3].validations.presence, equals(true));

      expect(result.fields[4].label, equals('created time'));
      expect(result.fields[4].readonly, equals(true));
      expect(result.fields[4].extra.extraDefault, equals(null));
      expect(result.fields[4].name, equals('created_time'));
      expect(result.fields[4].widget, equals('datetime'));
      expect(result.fields[4].required, equals(false));
      expect(result.fields[4].translated, equals(false));
      expect(result.fields[4].validations.length, equals(null));

      expect(result.fields[5].label, equals('updated time'));
      expect(result.fields[5].readonly, equals(true));
      expect(result.fields[5].extra.extraDefault, equals(null));
      expect(result.fields[5].name, equals('updated_time'));
      expect(result.fields[5].widget, equals('datetime'));
      expect(result.fields[5].required, equals(false));
      expect(result.fields[5].translated, equals(false));
      expect(result.fields[5].validations.length, equals(null));
    });
  });
}
