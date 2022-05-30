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

extension ParseToString on ViewType {
  String toShortString() {
    return toString().split('.').last;
  }
}

abstract class View {
  final ViewType viewType;

  View(this.viewType);
}

class FormSchema extends View {
  final String name;
  final List<Action> actions;

  FormSchema({
    required ViewType viewType,
    required this.name,
    required this.actions,
  }) : super(viewType);
}

class Choice {
  final String label;
  final String value;

  Choice({
    required this.label,
    required this.value,
  });

  toJson() {
    return {
      'label': label,
      'value': value,
    };
  }
}

class Action {
  final FieldType type;
  final String name;
  final String label;
  final bool required;
  final String? defaultValue;
  final int? maxLength;
  final bool readOnly;
  final List<Choice>? choices;

  Action({
    required this.type,
    required this.name,
    required this.label,
    required this.required,
    this.defaultValue,
    this.maxLength,
    required this.readOnly,
    this.choices,
  });
}

class ForeignKeyAction extends Action {
  final String relatedModel;

  ForeignKeyAction({
    required FieldType type,
    required String name,
    required String label,
    required bool required,
    required bool readOnly,
    required this.relatedModel,
  }) : super(
          type: type,
          name: name,
          label: label,
          required: required,
          readOnly: readOnly,
        );
}
