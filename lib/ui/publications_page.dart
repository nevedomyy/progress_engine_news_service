import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../store/state.dart';
import '../model/models.dart';
import 'article_page.dart';
import 'container.dart';
import 'textstyle.dart';
import 'behavior.dart';
import 'color.dart';


class PublicationsPage extends StatelessWidget{
  final String title;

  PublicationsPage(this.title);

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
              child: StoreConnector<AppState, PublicationsResp>(
                converter: (store) => store.state.publicationsResp,
                builder: (context, publicationsResp){
                  if(publicationsResp.error != null) return Center(
                    child: Text(
                      publicationsResp.error,
                      style: AppTextStyle.error,
                    ),
                  );
                  if(publicationsResp.list != null && !publicationsResp.isLoading) return ScrollConfiguration(
                    behavior: Behavior(),
                    child: ListView.builder(
                      itemCount: publicationsResp.list.length,
                      itemBuilder: (context, i){
                        return AppContainer(
                          onTap: () => Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ArticlePage(
                              title: publicationsResp.list[i].title,
                              text: publicationsResp.list[i].text,
                            )
                          )),
                          title: publicationsResp.list[i].title,
                          text: publicationsResp.list[i].text,
                        );
                      },
                    ),
                  );
                  return Center(
                      child: CircularProgressIndicator()
                  );
                },
              )
          )
        ],
      ),
    );
  }
}