import 'package:refine_gen/fetcher/schema_fetcher.dart';
import 'package:refine_gen/generator/refine_antd_generator.dart';
import 'package:refine_gen/types/drf_schema_types.dart';

void main() async {
  final urls = ['http://0.0.0.0:8000/api/maintenance/'];
  final fetchers = SchemaFetcher.fromList(urls);
  final results = await Future.wait(fetchers.map((f) => f.fetch()));
  final drfSchemas = results.map((r) => DRFSchema.fromJson(r)).toList();

  final generator = RefineAntdGenerator(inputSchema: drfSchemas[0]);
  generator.render();
  print('finish');
}
