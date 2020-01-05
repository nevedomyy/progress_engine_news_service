import 'package:cloud_firestore/cloud_firestore.dart';
import 'news.dart';


class NewsResp{
  final List<News> list;
  final String error;
  final bool isLoading;

  NewsResp(
    this.list,
    this.error,
    this.isLoading
  );

  NewsResp.fromSnapshot(List<DocumentSnapshot> documents)
    : list = documents.map((data) => News.fromSnapshot(data)).toList(),
      error = null,
      isLoading = false;

  NewsResp.withError(String error)
    : list = null,
      error = error,
      isLoading = false;

  NewsResp.loading()
      : list = null,
        error = null,
        isLoading = true;

  NewsResp.initial()
    : list = null,
      error = null,
      isLoading = false;
}