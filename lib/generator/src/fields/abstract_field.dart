import './types.dart';

abstract class Field {
  /// Field's name
  final String name;

  /// Field's type
  final FieldType type;

  Field({required this.name, required this.type});

  /// Render field to string
  String render();
}
