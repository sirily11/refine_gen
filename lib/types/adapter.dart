/// Adapter will transform T input to V output
abstract class Adapter<T, V> {
  final T inputSchema;

  Adapter({required this.inputSchema});

  List<V> transform();
}
