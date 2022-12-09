class CubeBox<T> {
  const CubeBox(this.data);

  final List<T> data;

  @override
  String toString() {
    return "{ data count: ${data.length} }";
  }

  T at(int index) {
    return data[index];
  }

  CubeBox<T> add(T newValue) {
    final newData = List<T>.from(data);
    newData.add(newValue);
    return CubeBox<T>(newData);
  }

  CubeBox<T> addAll(List<T> newValues) {
    final newData = List<T>.from(data);
    newData.addAll(newValues);
    return CubeBox<T>(newData);
  }

  CubeBox<T> remove(int index) {
    final newData = List<T>.from(data);
    newData.removeAt(index);
    return CubeBox<T>(newData);
  }

  CubeBox<T> update(int index, T updatedValue) {
    final newData = List<T>.from(data);
    newData[index] = updatedValue;
    return CubeBox<T>(newData);
  }
}
