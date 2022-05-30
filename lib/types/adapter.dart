import 'package:refine_gen/refine_gen.dart';

/// Adapter will transform T input to V output
abstract class Adapter<T, V> {
  late T inputSchema;
  final List<ViewType> viewTypes;

  Adapter({required this.viewTypes});

  void read(T inputSchema) {
    this.inputSchema = inputSchema;
  }

  /// transform input to output.
  List<V> transform();
}
