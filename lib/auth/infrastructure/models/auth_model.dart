import 'package:app_qr/users/entity/user.dart';

class AuthModel {
  String? token;
  User? user;

  AuthModel(this.token, this.user);

  AuthModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = User.fromJson(json['user']);
  }
}