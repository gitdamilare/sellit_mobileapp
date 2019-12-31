
import 'package:sellit_mobileapp/models/auth.dart';

abstract class UserRepository{
  Future<String> authenticate(Auth input);
  Future<void> deleteToken();
  Future<void> persistToken(String token);
  Future<bool> hasToken();
}

class UserServices extends UserRepository{
  @override
  Future<String> authenticate(Auth input) {
    // TODO: implement authenticate
    return null;
  }

  @override
  Future<void> deleteToken() {
    // TODO: implement deleteToken
    return null;
  }

  @override
  Future<bool> hasToken() {
    // TODO: implement hasToken
    return null;
  }

  @override
  Future<void> persistToken(String token) {
    // TODO: implement persistToken
    return null;
  }

}