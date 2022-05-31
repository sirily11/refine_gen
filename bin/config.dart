import 'dart:convert';

import 'package:refine_gen/refine_gen.dart';
import 'package:yaml/yaml.dart';

class Config {
  Config({
    required this.baseUrl,
    required this.viewTypes,
    required this.outFolder,
  });

  final String baseUrl;

  final List<ViewType> viewTypes;

  final String outFolder;

  static ViewType _viewTypeFromString(String viewType) {
    switch (viewType) {
      case 'create':
        return ViewType.create;
      case 'list':
        return ViewType.list;
      case 'detail':
        return ViewType.retrieve;
      case 'edit':
        return ViewType.edit;
      default:
        throw Exception('Unknown view type: $viewType');
    }
  }

  factory Config.fromRawJson(String str) => Config.fromJson(json.decode(str));

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        baseUrl: json['baseURL'],
        viewTypes: List<ViewType>.from(
          json['viewTypes'].map(
            (x) => _viewTypeFromString(x),
          ),
        ),
        outFolder: json['outFolder'],
      );

  factory Config.fromYAML(YamlMap yaml) => Config(
        baseUrl: yaml['baseURL'],
        viewTypes: List<ViewType>.from(
          yaml['viewTypes'].map(
            (x) => _viewTypeFromString(x),
          ),
        ),
        outFolder: yaml['outFolder'],
      );
}
