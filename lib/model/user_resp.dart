import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';


class UserResp{
  final User user;
  final String error;
  final bool isLoading;

  UserResp(
    this.user,
    this.error,
    this.isLoading
  );

  UserResp.fromSnapshot(List<DocumentSnapshot> documents)
    : user = documents.map((data) => User.fromSnapshot(data)).toList()[0],
      error = null,
      isLoading = false;

  UserResp.withError(String error)
    : user = null,
      error = error,
      isLoading = false;

  UserResp.loading()
    : user = null,
      error = null,
      isLoading = true;

  UserResp.initial()
    : user = null,
      error = null,
      isLoading = false;
}