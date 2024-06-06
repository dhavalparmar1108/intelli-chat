import 'package:get_storage/get_storage.dart';

class StorageService {

  GetStorage storage = GetStorage();
  // Save data to storage
  void saveData(String key, dynamic value) {
    storage.write(key, value);
  }

  // Read data from storage
  dynamic readData(String key) {
    return storage.read(key);
  }

  // Remove data from storage
  void removeData(String key) {
    storage.remove(key);
  }

  // Remove data from storage
  Future<void> erase() async{
    return await storage.erase();
  }
}
