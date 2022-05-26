import 'package:refine_gen/types/adapter.dart';
import 'package:refine_gen/types/types.dart';

class RefineAntdGenerator extends Generator {
  RefineAntdGenerator(
      {required List<Field> fields,
      required List<FormSchema> inputSchema,
      required Transformer transformer, required Adapter adapter})
      : super(inputSchema: inputSchema, transformer: transformer, adapter: adapter);
}
