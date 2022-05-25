import '../generator/fields/types.dart';

abstract class Field {
  /// Field's name
  final String name;

  /// Display name
  final String label;

  /// Field's type
  final FieldType type;

  final bool required;

  final bool readOnly;

  Field({
    required this.name,
    required this.type,
    required this.label,
    required this.required,
    required this.readOnly,
  });

  /// Render field to string
  String render();
}
