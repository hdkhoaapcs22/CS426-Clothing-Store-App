abstract class AbstractRepositoryInterface<T> {
  Future<List<T>> getAll();
  Future<T> getById(int id);
  Future<void> add(T item);
  Future<void> update(T item, int id);
  Future<void> delete(int id);
}
