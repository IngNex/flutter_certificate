import '../../domain/entity/user.dart';

class AuthModel {
  String? token;
  User? user;

  AuthModel(this.token, this.user);

  AuthModel.fromJson(Map<String, dynamic> json) {
    token = json['tokens']['accessToken'];
    user = User.fromJson(json['authenticatedUser']);
  }
}
