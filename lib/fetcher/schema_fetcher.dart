import 'package:dio/dio.dart';

class SchemaFetcher {
  final String path;

  SchemaFetcher({required this.path});

  static List<SchemaFetcher> fromList(List<String> path) {
    return path.map((p) => SchemaFetcher(path: p)).toList();
  }

  Future<Map<String, dynamic>> fetch() async {
    final response = await Dio().request(
      path,
      options: Options(method: 'options'),
    );
    return response.data;
  }
}
