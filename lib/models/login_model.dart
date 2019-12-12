
class LoginModel {
  int id;
  String title;
  LoginModel({this.id,this.title});


factory LoginModel.fromMap(Map<String,dynamic> json) {
    return LoginModel(
      id: json["id"],
      title: json["title"]
    );
}

}