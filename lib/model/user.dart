import 'package:cloud_firestore/cloud_firestore.dart';


class User{
  final String login;
  final String passw;
  final String name;
  final String mail;
  final String phone;
  final subscrUser;
  final subscrAuthor;

  User(
    this.login,
    this.passw,
    this.name,
    this.mail,
    this.phone,
    this.subscrUser,
    this.subscrAuthor,
  );

  User.fromMap(Map<String, dynamic> map)
    : login = map['login'],
      passw = map['password'],
      name = map['name'],
      mail = map['mail'],
      phone = map['phone'],
      subscrUser = map['subscr_user'],
      subscrAuthor = map['subscr_author'];

  User.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data);
}