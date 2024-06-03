import 'package:flutter/foundation.dart';
import 'package:my_app/models/user.dart';

class UserProvider extends ChangeNotifier {
  User? user;

  setUser(User userr) {
    user = userr;
  }
}
