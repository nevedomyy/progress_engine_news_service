import 'package:cloud_firestore/cloud_firestore.dart';


class Draft{
  final String draftId;
  final String title;
  final String text;

  Draft(
    this.draftId,
    this.title,
    this.text,
  );

  Draft.fromMap(String documentID, Map<String, dynamic> map)
    : draftId = documentID,
      title = map['title'],
      text = map['text'];

  Draft.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.documentID, snapshot.data);
}