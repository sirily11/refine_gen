import 'package:refine_gen/generator/generator.dart';

/// Represents a list of view types.
enum ViewType {
  /// Retrieve data from the server.
  retrieve,

  /// Edit current data.
  edit,

  /// Create new data.
  create,

  /// List data.
  list,

  /// Delete data
  delete,
}

class FormSchema {
  final ViewType viewType;
  final String name;
  final List<Action> actions;

  FormSchema({
    required this.viewType,
    required this.name,
    required this.actions,
  });
}

class Action {
  final FieldType type;
  final String name;
  final String label;
  final bool required;
  final String? defaultValue;
  final int? maxLength;
  final bool readOnly;

  Action({
    required this.type,
    required this.name,
    required this.label,
    required this.required,
    this.defaultValue,
    this.maxLength,
    required this.readOnly,
  });
}
