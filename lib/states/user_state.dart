import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserStatus { Unknown, Buyer, Owner }
enum FormStatus { Unknown, Done, Skipped }

class UserState with ChangeNotifier {
  FormStatus _formStatus;
  bool _isFirst = true;
  static UserStatus _userStatus = UserStatus.Unknown;

  UserState.instance();

  UserStatus get userStatus => _userStatus;
  FormStatus get formStatus => _formStatus;
  bool get isFirst => _isFirst;

  setUserStatus(UserStatus userStatus) async {
    _userStatus = userStatus;
    _isFirst = true;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_status', userStatus.toString());
    notifyListeners();
  }

  setFormStatus(FormStatus formStatus) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('form_status', formStatus.toString());
    notifyListeners();
  }
  setIsFirst(bool isFirst, UserStatus userStatus) async {
    _isFirst = isFirst;
    _userStatus = userStatus;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_first', _isFirst);
    notifyListeners();
  }
}
