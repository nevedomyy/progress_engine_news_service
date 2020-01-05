import '../store/state.dart';
import '../model/models.dart';
import '../actions/actions.dart';


AppState reducer(AppState currentState, dynamic action){
  if(action is Authenticate) return AppState.clone(currentState, userResp: action.userResp);

  if(action is AuthenticateLoading) return AppState.clone(currentState, userResp: action.userResp);

  if(action is Registration) return AppState.clone(currentState, userResp: UserResp(action.user, null, false));

  if(action is GetNews) return AppState.clone(currentState, newsResp: action.newsResp);

  if(action is GetNewsLoading) return AppState.clone(currentState, newsResp: action.newsResp);

  if(action is GetPublications) return AppState.clone(currentState, publicationsResp: action.publicationsResp);

  if(action is GetPublicationsLoading) return AppState.clone(currentState, publicationsResp: action.publicationsResp);

  if(action is GetDrafts) return AppState.clone(currentState, draftsResp: action.draftsResp);

  if(action is GetDraftsLoading) return AppState.clone(currentState, draftsResp: action.draftsResp);

  if(action is SaveUser) return AppState.clone(currentState, userResp: UserResp(action.user, null, false));

  if(action is CreateDraft) {
    final List<Draft> list = currentState.draftsResp.list;
    list.add(action.draft);
    return AppState.clone(currentState, draftsResp: DraftsResp(list, null, false));
  }

  if(action is SaveDraft) {
    final List<Draft> list = currentState.draftsResp.list;
    list.removeAt(action.index);
    list.add(action.draft);
    return AppState.clone(currentState, draftsResp: DraftsResp(list, null, false));
  }

  if(action is PublicDraft) {
    final List<Draft> listDrafts = currentState.draftsResp.list;
    final List<News> listNews = currentState.newsResp.list;
    listDrafts.removeAt(action.index);
    listNews.add(News(
      action.draft.title,
      action.draft.text,
      action.author,
      action.dateTime,
      action.userId
    ));
    return AppState.clone(
      currentState,
      draftsResp: DraftsResp(listDrafts, null, false),
      newsResp: NewsResp(listNews, null, false)
    );
  }

  if(action is LogOut) return AppState.initial();

  return currentState;
}