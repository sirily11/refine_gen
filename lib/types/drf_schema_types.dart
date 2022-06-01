import 'dart:convert';

class DRFSchema {
  DRFSchema({
    required this.name,
    required this.description,
    required this.renders,
    required this.parses,
    required this.actions,
    required this.fields,
    required this.saveTwice,
    required this.searchEnabled,
    required this.conditionalFormatting,
  });

  final String name;
  final String description;
  final List<String> renders;
  final List<String> parses;
  final Actions actions;
  final List<Field> fields;
  final bool saveTwice;
  final bool searchEnabled;
  final ConditionalFormatting conditionalFormatting;

  factory DRFSchema.fromRawJson(String str) =>
      DRFSchema.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DRFSchema.fromJson(Map<String, dynamic> json) => DRFSchema(
        name: json['name'],
        description: json['description'],
        renders: List<String>.from(json['renders'].map((x) => x)),
        parses: List<String>.from(json['parses'].map((x) => x)),
        actions: Actions.fromJson(json['actions']),
        fields: List<Field>.from(json['fields'].map((x) => Field.fromJson(x))),
        saveTwice: json['save_twice'],
        searchEnabled: json['search_enabled'],
        conditionalFormatting: ConditionalFormatting.fromJson(
            Map.from(json['conditional_formatting'])),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'renders': List<dynamic>.from(renders.map((x) => x)),
        'parses': List<dynamic>.from(parses.map((x) => x)),
        'actions': actions.toJson(),
        'fields': List<dynamic>.from(fields.map((x) => x.toJson())),
        'save_twice': saveTwice,
        'search_enabled': searchEnabled,
        'conditional_formatting': conditionalFormatting.toJson(),
      };
}

class Actions {
  final Map<String, ActionItem>? post;

  Actions({
    this.post,
  });

  factory Actions.fromRawJson(String str) => Actions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Actions.fromJson(Map<String, dynamic> json) => Actions(
        post: json['POST'] == null
            ? null
            : Map.from(json['POST']).map((k, v) =>
                MapEntry<String, ActionItem>(k, ActionItem.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        'POST': post == null
            ? null
            : Map.from(post!)
                .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class ActionItem {
  ActionItem({
    required this.type,
    required this.required,
    required this.readOnly,
    required this.label,
    this.maxLength,
  });

  final String type;
  final bool required;
  final bool readOnly;
  final String label;
  final int? maxLength;

  factory ActionItem.fromRawJson(String str) =>
      ActionItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActionItem.fromJson(Map<String, dynamic> json) => ActionItem(
        type: json['type'],
        required: json['required'],
        readOnly: json['read_only'],
        label: json['label'],
        maxLength: json['max_length'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'required': required,
        'read_only': readOnly,
        'label': label,
        'max_length': maxLength,
      };
}

class ConditionalFormatting {
  ConditionalFormatting();

  factory ConditionalFormatting.fromRawJson(String str) =>
      ConditionalFormatting.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConditionalFormatting.fromJson(Map<String, dynamic> json) =>
      ConditionalFormatting();

  Map<String, dynamic> toJson() => {};
}

class Field {
  Field({
    required this.label,
    required this.readonly,
    required this.extra,
    required this.name,
    required this.widget,
    required this.required,
    required this.translated,
    required this.validations,
  });

  final String label;
  final bool readonly;
  final Extra extra;
  final String name;
  final String widget;
  final bool required;
  final bool translated;
  final Validations validations;

  factory Field.fromRawJson(String str) => Field.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        label: json['label'],
        readonly: json['readonly'],
        extra: Extra.fromJson(Map.from(json['extra'])),
        name: json['name'],
        widget: json['widget'],
        required: json['required'],
        translated: json['translated'],
        validations: Validations.fromJson(Map.from(json['validations'])),
      );

  Map<String, dynamic> toJson() => {
        'label': label,
        'readonly': readonly,
        'extra': extra.toJson(),
        'name': name,
        'widget': widget,
        'required': required,
        'translated': translated,
        'validations': validations.toJson(),
      };
}

class Extra {
  Extra({
    this.extraDefault,
    this.relatedModel,
    this.choices,
  });

  final String? extraDefault;
  final String? relatedModel;
  final List<Choice>? choices;

  factory Extra.fromRawJson(String str) => Extra.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        extraDefault:
            // ignore: prefer_null_aware_operators
            json['default'] == null ? null : json['default'].toString(),
        relatedModel: json['related_model'],
        choices: json['choices'] == null
            ? null
            : List<Choice>.from(json['choices'].map((x) => Choice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'default': extraDefault,
        'related_model': relatedModel,
        'choices': choices == null
            ? null
            : List<dynamic>.from(
                choices!.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}

class Choice {
  Choice({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  factory Choice.fromRawJson(String str) => Choice.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        label: json['label'],
        value: json['value'],
      );

  Map<String, dynamic> toJson() => {
        'label': label,
        'value': value,
      };
}

class Validations {
  Validations({
    this.length,
    this.presence,
  });

  final Length? length;
  final bool? presence;

  factory Validations.fromRawJson(String str) =>
      Validations.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Validations.fromJson(Map<String, dynamic> json) => Validations(
        length: json['length'] == null ? null : Length.fromJson(json['length']),
        presence: json['presence'],
      );

  Map<String, dynamic> toJson() => {
        'length': length?.toJson(),
        'presence': presence,
      };
}

class Length {
  Length({
    required this.maximum,
  });

  final int maximum;

  factory Length.fromRawJson(String str) => Length.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Length.fromJson(Map<String, dynamic> json) => Length(
        maximum: json['maximum'],
      );

  Map<String, dynamic> toJson() => {
        'maximum': maximum,
      };
}
