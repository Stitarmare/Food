abstract class LoginContract {
  void performLogin(String email, String password);
  void onBackPresed();
}

abstract class LoginView {
  void loginSuccess();
  void loginFailed();
}
