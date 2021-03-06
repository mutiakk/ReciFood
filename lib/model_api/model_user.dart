// To parse this JSON data, do
//
//     final listUser = listUserFromJson(jsonString);

// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.msg,
    required this.token,
    required this.user,
  });

  String msg;
  String token;
  UserClass user;

  factory User.fromJson(Map<String, dynamic> json) => User(
    msg: json["msg"],
    token: json["token"],
    user: UserClass.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "token": token,
    "user": user.toJson(),
  };
}

class UserClass {
  UserClass({
    required this.id,
    required this.username,
    required this.password,
    required this.registered,
    required this.login,
  });

  String id;
  String username;
  String password;
  DateTime registered;
  DateTime login;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
    id: json["id"],
    username: json["username"],
    password: json["password"],
    registered: DateTime.parse(json["registered"]),
    login: DateTime.parse(json["login"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "password": password,
    "registered": registered.toIso8601String(),
    "login": login.toIso8601String(),
  };
}


// import 'dart:convert';
//
// ListUser listUserFromJson(String str) => ListUser.fromJson(json.decode(str));
//
// String listUserToJson(ListUser data) => json.encode(data.toJson());
//
// class ListUser {
//   ListUser({
//     required this.page,
//     required this.perPage,
//     required this.total,
//     required this.totalPages,
//     required this.data,
//     required this.support,
//   });
//
//   int page;
//   int perPage;
//   int total;
//   int totalPages;
//   List<Datum> data;
//   Support support;
//
//   factory ListUser.fromJson(Map<String, dynamic> json) => ListUser(
//     page: json["page"],
//     perPage: json["per_page"],
//     total: json["total"],
//     totalPages: json["total_pages"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//     support: Support.fromJson(json["support"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "page": page,
//     "per_page": perPage,
//     "total": total,
//     "total_pages": totalPages,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     "support": support.toJson(),
//   };
// }
//
// class Datum {
//   Datum({
//     required this.id,
//     required this.email,
//     required this.firstName,
//     required this.lastName,
//     required this.avatar,
//   });
//
//   int id;
//   String email;
//   String firstName;
//   String lastName;
//   String avatar;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["id"],
//     email: json["email"],
//     firstName: json["first_name"],
//     lastName: json["last_name"],
//     avatar: json["avatar"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "email": email,
//     "first_name": firstName,
//     "last_name": lastName,
//     "avatar": avatar,
//   };
// }
//
// class Support {
//   Support({
//     required this.url,
//     required this.text,
//   });
//
//   String url;
//   String text;
//
//   factory Support.fromJson(Map<String, dynamic> json) => Support(
//     url: json["url"],
//     text: json["text"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "url": url,
//     "text": text,
//   };
// }