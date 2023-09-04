import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    final String id;
    final String username;
    final String role;

    User({
        required this.id,
        required this.username,
        required this.role,
    });

    User copyWith({
        String? id,
        String? username,
        String? role,
    }) => 
        User(
            id: id ?? this.id,
            username: username ?? this.username,
            role: role ?? this.role,
        );

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "role": role,
    };
}