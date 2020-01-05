import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news_service_app/store/store.dart';
import '../middleware/thunk.dart';
import '../store/state.dart';
import '../model/models.dart';
import 'editdraft_page.dart';
import 'container.dart';
import 'textstyle.dart';
import 'behavior.dart';
import 'color.dart';
import 'dart:math';


class DraftsPage extends StatelessWidget{
  final String title;

  DraftsPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: AppTextStyle.title,
          ),
          SizedBox(height: 30),
          Expanded(
              child: StoreConnector<AppState, DraftsResp>(
                converter: (store) => store.state.draftsResp,
                builder: (context, draftsResp){
                  if(draftsResp.error != null) return Center(
                    child: Text(
                      draftsResp.error,
                      style: AppTextStyle.error,
                    ),
                  );
                  if(draftsResp.list != null && !draftsResp.isLoading) return ScrollConfiguration(
                    behavior: Behavior(),
                    child: ListView.builder(
                      itemCount: draftsResp.list.length,
                      itemBuilder: (context, i){
                        return AppContainer(
                          onTap: () => Navigator.push(context, MaterialPageRoute(
                            builder: (context) => EditDraftPage(
                              index: i,
                              draftId: draftsResp.list[i].draftId,
                              title: draftsResp.list[i].title,
                              text: draftsResp.list[i].text,
                            )
                          )),
                          title: draftsResp.list[i].title,
                          text: draftsResp.list[i].text,
                        );
                      },
                    ),
                  );
                  return Center(
                      child: CircularProgressIndicator()
                  );
                },
              )
          ),
          StoreConnector<AppState, Function(int index, String draftId)>(
            converter: (store) => (index, draftId) => store.dispatch(createDraft(index, draftId, '', '')),
            builder: (context, createDraft){
              return Center(
                child: Ink(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      boxShadow: [
                        BoxShadow(offset: Offset(2.0, 4.0), blurRadius: 6.0, color: AppColor.shadow)
                      ]
                  ),
                  child: InkWell(
                    onTap: () {
                      final int index = store.state.draftsResp.list.length;
                      final String draftId = 'draft_' + Random().nextInt(9999999).toString();
                      createDraft(index, draftId);
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => EditDraftPage(
                            index: index,
                            draftId: draftId,
                            title: '',
                            text: '',
                          )
                      ));
                    },
                    borderRadius: BorderRadius.circular(25),
                    highlightColor: Colors.black12,
                    splashColor: Colors.black12,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Создать',
                        style: AppTextStyle.btn,
                      ),
                    ),
                  ),
                ),
              );
            }
          ),
          SizedBox(height: 16)
        ],
      ),
    );
  }
}