//Quiero q sea abstracta
//Puedo dp cambiar a Isar u otro en vez de Shared Preferences
abstract class KeyValueStorageService {
  Future<void> setKeyValue<T>(String key, T value); //T es 1 variable genérica
  Future<T?> getValue<T> (String key); //regreso una variable T opcional. Y solocito una variable T
  Future<bool> removeKey (String key);
}
