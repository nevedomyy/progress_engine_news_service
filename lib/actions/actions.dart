import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/models.dart';


class Authenticate{
  final UserResp _userResp;
  Authenticate(this._userResp);
  UserResp get userResp => _userResp;
}

class AuthenticateLoading{
  UserResp get userResp => UserResp.loading();
}

class Registration{
  final User _user;
  Registration(this._user);
  User get user => _user;
}

class GetNews{
  final NewsResp _newsResp;
  GetNews(this._newsResp);
  NewsResp get newsResp => _newsResp;
}

class GetNewsLoading{
  NewsResp get newsResp => NewsResp.loading();
}

class GetPublications{
  final PublicationsResp _publicationsResp;
  GetPublications(this._publicationsResp);
  PublicationsResp get publicationsResp => _publicationsResp;
}

class GetPublicationsLoading{
  PublicationsResp get publicationsResp => PublicationsResp.loading();
}

class GetDrafts{
  final DraftsResp _draftsResp;
  GetDrafts(this._draftsResp);
  DraftsResp get draftsResp => _draftsResp;
}

class GetDraftsLoading{
  DraftsResp get draftsResp => DraftsResp.loading();
}

class SaveUser{
  final User _user;
  SaveUser(this._user);
  User get user => _user;
}

class CreateDraft{
  final int _index;
  final Draft _draft;
  CreateDraft(this._index, this._draft);
  int get index => _index;
  Draft get draft => _draft;
}

class SaveDraft{
  final int _index;
  final Draft _draft;
  SaveDraft(this._index, this._draft);
  int get index => _index;
  Draft get draft => _draft;
}

class PublicDraft{
  final int _index;
  final Draft _draft;
  final String _author;
  final Timestamp _dateTime;
  final String _userId;
  PublicDraft(this._index, this._draft, this._author, this._dateTime, this._userId);
  int get index => _index;
  Draft get draft => _draft;
  String get author => _author;
  Timestamp get dateTime => _dateTime;
  String get userId => _userId;
}

class LogOut{}