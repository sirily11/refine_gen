/// Adapter will transform T input to V output
abstract class Adapter<T, V> {
  late T inputSchema;

  Adapter();

  void read(T inputSchema) {
    this.inputSchema = inputSchema;
  }

  List<V> transform();
}
