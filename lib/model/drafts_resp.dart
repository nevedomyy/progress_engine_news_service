import 'package:cloud_firestore/cloud_firestore.dart';
import 'draft.dart';


class DraftsResp{
  final List<Draft> list;
  final String error;
  final bool isLoading;

  DraftsResp(
    this.list,
    this.error,
    this.isLoading
  );

  DraftsResp.fromSnapshot(List<DocumentSnapshot> documents)
    : list = documents.map((data) => Draft.fromSnapshot(data)).toList(),
      error = null,
      isLoading = false;

  DraftsResp.withError(String error)
    : list = null,
      error = error,
      isLoading = false;

  DraftsResp.loading()
      : list = null,
        error = null,
        isLoading = true;

  DraftsResp.initial()
    : list = null,
      error = null,
      isLoading = false;
}