import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/models.dart';
import '../store/storage.dart';
import 'dart:math';


class FirestoreProvider{
  final Firestore _firestore = Firestore.instance;

  Future<UserResp> authenticate(String login, String passw) async{
    try{
      final QuerySnapshot snapshot = await _firestore.collection('users')
          .where('login', isEqualTo: login)
          .where('password', isEqualTo: passw)
          .getDocuments();
      final List<DocumentSnapshot> documents = snapshot.documents;
      if(documents.length == 1) {
        await storage.write(key: 'userId', value: documents[0].documentID.toString());
        return UserResp.fromSnapshot(documents);
      }
      return UserResp.withError('Неправильные логин/пароль');
    }catch (e){
      return UserResp.withError(e.toString());
    }
  }

  Future<void> registration(String docName, String login, String passw, String name, String mail, String phone){
    return _firestore.collection('users').document(docName).setData({
      'login': login,
      'password': passw,
      'name': name,
      'mail': mail,
      'phone': phone,
      'subscr_user': [],
      'subscr_author': [],
    });
  }

  Future<NewsResp> getNews() async{
    try{
      final QuerySnapshot snapshot = await _firestore.collection('news').orderBy('date_time', descending: true).getDocuments();
      final List<DocumentSnapshot> documents = snapshot.documents;
      return NewsResp.fromSnapshot(documents);
    }catch (e){
      return NewsResp.withError(e.toString());
    }
  }

  Future<PublicationsResp> getPublications() async{
    try{
      final String userId = await storage.read(key: 'userId');
      final QuerySnapshot snapshot = await _firestore.collection('news').where('user_id', isEqualTo: userId).getDocuments();
      final List<DocumentSnapshot> documents = snapshot.documents;
      return PublicationsResp.fromSnapshot(documents);
    }catch (e){
      return PublicationsResp.withError(e.toString());
    }
  }

  Future<DraftsResp> getDrafts() async{
    try{
      final String userId = await storage.read(key: 'userId');
      final QuerySnapshot snapshot = await _firestore.collection('drafts').where('user_id', isEqualTo: userId).getDocuments();
      final List<DocumentSnapshot> documents = snapshot.documents;
      return DraftsResp.fromSnapshot(documents);
    }catch (e){
      return DraftsResp.withError(e.toString());
    }
  }

  Future<void> saveUser(String login, String passw, String name, String mail, String phone, List<String> subscrUser, List<String> subscrAuthor) async{
    final String userId = await storage.read(key: 'userId');
    return _firestore.collection('users').document(userId).setData({
      'login': login,
      'password': passw,
      'name': name,
      'mail': mail,
      'phone': phone,
      'subscr_user': subscrUser,
      'subscr_author': subscrAuthor,
    });
  }

  Future<void> createDraft(String draftId, String title, String text) async{
    final String userId = await storage.read(key: 'userId');
    return _firestore.collection('drafts').document(draftId).setData({
      'user_id': userId,
      'title': title,
      'text': text,
    });
  }

  Future<void> saveDraft(String draftId, String title, String text) async{
    final String userId = await storage.read(key: 'userId');
    return _firestore.collection('drafts').document(draftId).setData({
      'user_id': userId,
      'title': title,
      'text': text,
    });
  }

  Future<void> publicDraft(String draftId, String title, String text, String author, Timestamp dateTime, String userId) async{
    final String newsId = 'news_' + Random().nextInt(9999999).toString();
    _firestore.collection('news').document(newsId).setData({
      'user_id': userId,
      'title': title,
      'text': text,
      'author': author,
      'date_time': dateTime,
    });
    return _firestore.collection('drafts').document(draftId).delete();
  }
}