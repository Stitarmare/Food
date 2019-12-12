
import 'package:flutter/widgets.dart';
import 'package:foodzi/presenter/login_presenter.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginViewState();
  }
}


class _LoginViewState extends State<LoginView> implements LoginPresenterInterface {

  LoginPresenter _loginPresenter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loginPresenter = LoginPresenter(this);
    _loginPresenter.callLogin();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

  @override
  void onFaieldLogin() {
    // TODO: implement onFaieldLogin
  }

  @override
  void onSuccessLogin() {
    // TODO: implement onSuccessLogin
  }
}
