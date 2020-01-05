import 'package:cloud_firestore/cloud_firestore.dart';


class News{
  final String title;
  final String text;
  final String author;
  final Timestamp dateTime;
  final String userId;

  News(
    this.title,
    this.text,
    this.author,
    this.dateTime,
    this.userId,
  );

  News.fromMap(Map<String, dynamic> map)
    : title = map['title'],
      text = map['text'],
      author = map['author'],
      dateTime = map['date_time'],
      userId = map['user_id'];

  News.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data);
}