import 'package:refine_gen/types/types.dart';

class RefineAntdGenerator extends Generator {
  RefineAntdGenerator(
      {required List<Field> fields,
      required List<FormSchema> inputSchema,
      required Transformer transformer})
      : super(inputSchema: inputSchema, transformer: transformer);
}
