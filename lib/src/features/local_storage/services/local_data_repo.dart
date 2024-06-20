// Objectbox cache repository,
import 'package:objectbox/objectbox.dart';

class LocalDataRepo<T> {
  final Store _store;
  late final Box<T> box;

  LocalDataRepo(this._store) {
    box = _store.box<T>();
  }

  // The put method inserts or update an object in the database
  // and returns the id of the object.
  Future<int> put(T cache) async {
    return box.put(cache);
  }

  // The get method retrieves an object from the database by id.
  Future<T?> get(int id) async {
    return box.get(id);
  }

  // The remove method deletes an object from the database by id.
  // It returns true if the object was deleted, false otherwise.
  Future<bool> remove(int id) async {
    return box.remove(id);
  }

  // The getAll method retrieves all objects of a given type from the database.
  Future<List<T>> getAll() async {
    return box.getAll();
  }

  // The removeAll method deletes all objects of a given type from the database.
  // It returns the number of objects deleted.
  Future<int> removeAll() async {
    return box.removeAll();
  }
}
