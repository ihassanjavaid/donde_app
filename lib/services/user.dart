import '../store.dart';
class User {
  static String phoneNumber;
  static StoreRetrieve store = StoreRetrieve();

  static List getCurrentUserData() {
    return store.getUserData(phoneNumber);
  }

}