import 'package:cloud_firestore/cloud_firestore.dart';


class Publication{
  final String title;
  final String text;

  Publication(
    this.title,
    this.text,
  );

  Publication.fromMap(Map<String, dynamic> map)
    : title = map['title'],
      text = map['text'];

  Publication.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data);
}