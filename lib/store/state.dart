import '../model/models.dart';


class AppState{
  final UserResp userResp;
  final NewsResp newsResp;
  final PublicationsResp publicationsResp;
  final DraftsResp draftsResp;

  AppState(
    this.userResp,
    this.newsResp,
    this.publicationsResp,
    this.draftsResp,
  );

  AppState.clone(AppState state,{
    UserResp userResp,
    NewsResp newsResp,
    PublicationsResp publicationsResp,
    DraftsResp draftsResp,
  }) : this(
    userResp ?? state.userResp,
    newsResp ?? state.newsResp,
    publicationsResp ?? state.publicationsResp,
    draftsResp ?? state.draftsResp,
  );

  AppState.initial()
    : userResp = UserResp.initial(),
      newsResp = NewsResp.initial(),
      publicationsResp = PublicationsResp.initial(),
      draftsResp = DraftsResp.initial();
}