class StoreModel {
  String? id;
  String? username;
  String? role;
  String? token;

  StoreModel(this.id, this.username, this.token, this.role);

  StoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    role = json['role'];
    token = json['token'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id!,
      'username': username!,
      'role': role!,
      'token': token!,
    };
  }
}
