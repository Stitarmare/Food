import 'package:foodzi/Login/LoginContractor.dart';

class LoginPresenter extends LoginContract {
  LoginView mLoginView;

  LoginPresenter(LoginView mView) {
    this.mLoginView = mView;
  }

  @override
  void onBackPresed() {}

  @override
  void performLogin(String email, String password) {
//ApiCall
    mLoginView.loginSuccess();
  }
}
