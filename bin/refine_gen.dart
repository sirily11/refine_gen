import 'dart:io';

import 'package:dio/dio.dart';
import 'package:refine_gen/refine_gen.dart';
import 'package:refine_gen/types/drf_schema_types.dart';
import 'package:yaml/yaml.dart';

import 'config.dart';

class Endpoint {
  final String url;

  final String key;

  Endpoint({required this.url, required this.key});
}

Future<List<Endpoint>> _getEndpoints(String baseURL) async {
  final response = await Dio().get(baseURL);
  final data = response.data;
  final endpoints = data!.values.toList();
  final keys = List<String>.from(data!.keys.toList());
  return List<String>.from(endpoints)
      .asMap()
      .entries
      .map<Endpoint>(
          (entry) => Endpoint(key: keys[entry.key], url: entry.value))
      .toList();
}

void main() async {
  final config = File('config.yaml');
  final YamlMap configYaml = loadYaml(config.readAsStringSync());
  final configObj = Config.fromYAML(configYaml);

  final urls = await _getEndpoints(configObj.baseUrl);
  final fetchers = SchemaFetcher.fromList(urls
      .where((element) => !configObj.excludePaths.contains(element.key))
      .map((element) => element.url)
      .toList());
  final results = await Future.wait(fetchers.map((f) => f.fetch()));
  final drfSchemas = results.map((r) => DRFSchema.fromJson(r)).toList();

  for (final drfSchema in drfSchemas) {
    final generator = RefineAntdGenerator(
      inputSchema: drfSchema,
      viewTypes: configObj.viewTypes,
      outputDir: configObj.outFolder,
    );
    generator.render();
  }

  print('finish');
}
