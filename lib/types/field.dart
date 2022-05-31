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

  String? renderInitialValue(ViewType viewType) {
    switch (viewType) {
      case ViewType.list:
        return renderListInitialValue();
      case ViewType.retrieve:
        return renderDetailInitialValue();
      case ViewType.edit:
        return renderEditInitialValue();
      case ViewType.create:
        return renderCreateInitialValue();
      case ViewType.delete:
        return renderDeleteInitialValue();
    }
  }

  String? renderListInitialValue() {
    return null;
  }

  String? renderDetailInitialValue() {
    return null;
  }

  String? renderEditInitialValue() {
    return null;
  }

  String? renderCreateInitialValue() {
    return null;
  }

  String? renderDeleteInitialValue() {
    return null;
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
    switch (viewType) {
      case ViewType.list:
        return renderListSelection();
      case ViewType.retrieve:
        return renderDetailSelection();
      case ViewType.edit:
        return renderEditSelection();
      case ViewType.create:
        return renderCreateSelection();
      case ViewType.delete:
        return renderDeleteSelection();
    }
  }

  String renderCreateSelection() {
    final string = path.basename(foreignKey);

    return '''const { selectProps: $selectionName } = useSelect({
    resource: "$string",
    optionLabel: "title",
    optionValue: "id"
  });
''';
  }

  String renderEditSelection() {
    final string = path.basename(foreignKey);

    String defaultValue = 'defaultValue: queryResult?.data?.data?.$name?.id,';

    return '''const { selectProps: $selectionName } = useSelect({
    resource: "$string",
    optionLabel: "title",
    optionValue: "id",
    $defaultValue
  });
''';
  }

  String renderListSelection() {
    return renderCreateSelection();
  }

  String renderDetailSelection() {
    final string = path.basename(foreignKey);

    return '''const { data: $selectionName } = useOne({
    resource: "$string",
    id: record?.$name,
    queryOptions: {
          enabled: !!record?.$name,
    },
  });
''';
  }

  String renderDeleteSelection() {
    return renderCreateSelection();
  }
}
