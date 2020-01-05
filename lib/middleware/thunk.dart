import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import '../model/models.dart';
import '../store/state.dart';
import '../store/storage.dart';
import '../actions/actions.dart';
import '../ui/keys.dart';
import 'firestore_provider.dart';


ThunkAction<AppState> authenticate(String login, String passw) {
  FirestoreProvider provider = FirestoreProvider();
  return (Store<AppState> store) async {
    store.dispatch(AuthenticateLoading());
    UserResp userResp = await provider.authenticate(login, passw);
    if(userResp != null && userResp.user != null) Keys.navigationKey.currentState.pushReplacementNamed('menuPage');
    store.dispatch(Authenticate(userResp));
  };
}

ThunkAction<AppState> registration(String docName, String login, String passw, String name, String mail, String phone) {
  FirestoreProvider provider = FirestoreProvider();
  return (Store<AppState> store) async {
    await provider.registration(docName, login, passw, name, mail, phone);
    final User user = User(login, passw, name, mail, phone, [], []);
    store.dispatch(Registration(user));
    Keys.navigationKey.currentState.pushReplacementNamed('menuPage');
  };
}

ThunkAction<AppState> getNews() {
  FirestoreProvider provider = FirestoreProvider();
  return (Store<AppState> store) async {
    store.dispatch(GetNewsLoading());
    NewsResp newsResp = await provider.getNews();
    store.dispatch(GetNews(newsResp));
  };
}

ThunkAction<AppState> getPublications() {
  FirestoreProvider provider = FirestoreProvider();
  return (Store<AppState> store) async {
    store.dispatch(GetPublicationsLoading());
    PublicationsResp publicationsResp = await provider.getPublications();
    store.dispatch(GetPublications(publicationsResp));
  };
}

ThunkAction<AppState> getDrafts() {
  FirestoreProvider provider = FirestoreProvider();
  return (Store<AppState> store) async {
    store.dispatch(GetDraftsLoading());
    DraftsResp draftsResp = await provider.getDrafts();
    store.dispatch(GetDrafts(draftsResp));
  };
}

ThunkAction<AppState> saveUser(String login, String passw, String name, String mail, String phone, List<String> subscrUser, List<String> subscrAuthor) {
  FirestoreProvider provider = FirestoreProvider();
  return (Store<AppState> store) async {
    await provider.saveUser(login, passw, name, mail, phone, subscrUser, subscrAuthor);
    final User user = User(login, passw, name, mail, phone, subscrUser, subscrAuthor);
    store.dispatch(SaveUser(user));
  };
}

ThunkAction<AppState> createDraft(int index, String draftId, String title, String text) {
  FirestoreProvider provider = FirestoreProvider();
  return (Store<AppState> store) async {
    await provider.createDraft(draftId, title, text);
    store.dispatch(CreateDraft(index, Draft(draftId, title, text)));
  };
}

ThunkAction<AppState> saveDraft(int index, String draftId, String title, String text) {
  FirestoreProvider provider = FirestoreProvider();
  return (Store<AppState> store) async {
    await provider.saveDraft(draftId, title, text);
    store.dispatch(SaveDraft(index, Draft(draftId, title, text)));
  };
}

ThunkAction<AppState> publicDraft(int index, String draftId, String title, String text) {
  FirestoreProvider provider = FirestoreProvider();
  return (Store<AppState> store) async {
    final String userId = await storage.read(key: 'userId');
    final String author = store.state.userResp.user.name;
    final Timestamp dateTime = Timestamp.now();
    await provider.publicDraft(draftId, title, text, author, dateTime, userId);
    store.dispatch(PublicDraft(index, Draft(draftId, title, text), author, dateTime, userId));
    Keys.navigationKey.currentState.pop();
  };
}

ThunkAction<AppState> subscription(String userId, String author) {
  FirestoreProvider provider = FirestoreProvider();
  return (Store<AppState> store) async {
    User user = store.state.userResp.user;
    List<String> subscrUser = List.from(store.state.userResp.user.subscrUser);
    if(subscrUser.contains(userId)) subscrUser.remove(userId);
    else subscrUser.add(userId);
    List<String> subscrAuthor = List.from(store.state.userResp.user.subscrAuthor);
    if(subscrAuthor.contains(author)) subscrAuthor.remove(author);
    else subscrAuthor.add(author);
    await provider.saveUser(user.login, user.passw, user.name, user.mail, user.phone, subscrUser, subscrAuthor);
    store.dispatch(SaveUser(User(user.login, user.passw, user.name, user.mail, user.phone, subscrUser, subscrAuthor)));
    Keys.navigationKey.currentState.pop();
  };
}