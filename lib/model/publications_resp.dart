import 'package:cloud_firestore/cloud_firestore.dart';
import 'publication.dart';


class PublicationsResp{
  final List<Publication> list;
  final String error;
  final bool isLoading;

  PublicationsResp(
    this.list,
    this.error,
    this.isLoading
  );

  PublicationsResp.fromSnapshot(List<DocumentSnapshot> documents)
    : list = documents.map((data) => Publication.fromSnapshot(data)).toList(),
      error = null,
      isLoading = false;

  PublicationsResp.withError(String error)
    : list = null,
      error = error,
      isLoading = false;

  PublicationsResp.loading()
      : list = null,
        error = null,
        isLoading = true;

  PublicationsResp.initial()
    : list = null,
      error = null,
      isLoading = false;
}