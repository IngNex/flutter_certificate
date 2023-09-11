class User {
  String? id;
  String? username;
  String? role;

  User(
      this.id,
      this.username,
      this.role,);

  User.empty() {
    id = username = role  = '';
  }

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    role = json['role'];
    
  }

  Map<String, dynamic> toMap() {
    return {'username': username!, 'role': role!};
  }
}
