import 'package:foodzi/Models/MenuCartDisplayModel.dart';
import 'package:foodzi/Models/authmodel.dart';
import 'package:foodzi/Models/loginmodel.dart';

class Globle {
  static final Globle _globle = Globle.internal();

  factory Globle() {
    return _globle;
  }

  Globle.internal();
  LoginModel loginModel;
  MenuCartDisplayModel menuCartDisplayModel;

  String colorscode;

  var authKey;
}
