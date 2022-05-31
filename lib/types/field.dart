import 'package:refine_gen/types/schema.dart';

import '../generator/fields/types.dart';
import 'package:path/path.dart' as path;

abstract class Field {
  /// Field's name
  final String name;

  /// Display name
  final String label;

  /// Field's type
  final FieldType type;

  final bool required;

  final bool readOnly;

  final int? maxLength;

  final String? defaultValue;

  Field({
    required this.name,
    required this.type,
    required this.label,
    required this.required,
    required this.readOnly,
    required this.maxLength,
    required this.defaultValue,
  });

  /// Render field to string
  /// If field is readOnly, it will return null.
  String? render(ViewType viewType) {
    switch (viewType) {
      case ViewType.list:
        return renderList();
      case ViewType.retrieve:
        return renderDetail();
      case ViewType.edit:
        return renderEdit();
      case ViewType.create:
        return renderCreate();
      case ViewType.delete:
        return renderDelete();
    }
  }

  String renderList() {
    throw UnimplementedError();
  }

  String renderDetail() {
    throw UnimplementedError();
  }

  String renderEdit() {
    throw UnimplementedError();
  }

  String renderCreate() {
    throw UnimplementedError();
  }

  String renderDelete() {
    throw UnimplementedError();
  }
}

// Model field will connect to another model
abstract class ModelField extends Field {
  final String foreignKey;

  ModelField({
    required String name,
    required String label,
    required bool required,
    required bool readOnly,
    required int? maxLength,
    required String? defaultValue,
    required this.foreignKey,
  }) : super(
          name: name,
          type: FieldType.string,
          label: label,
          required: required,
          readOnly: readOnly,
          maxLength: maxLength,
          defaultValue: defaultValue,
        );

  String get selectionName => '${name}Selection';

  String renderSelection(ViewType viewType) {
    final string = path.basename(foreignKey);

    String defaultValue = 'defaultValue: queryResult?.data?.data?.$name?.id,';

    if (viewType == ViewType.create) {
      defaultValue = '';
    }

    return '''const { selectProps: $selectionName } = useSelect({
    resource: "$string",
    optionLabel: "title",
    optionValue: "id",
    $defaultValue
  });
''';
  }
}
