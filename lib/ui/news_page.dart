import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import '../store/state.dart';
import '../store/store.dart';
import '../model/models.dart';
import '../middleware/thunk.dart';
import 'article_page.dart';
import 'container.dart';
import 'textstyle.dart';
import 'behavior.dart';
import 'color.dart';


class NewsPage extends StatelessWidget{
  final String title;

  NewsPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
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
              child: StoreConnector<AppState, NewsResp>(
                converter: (store) => store.state.newsResp,
                builder: (context, newsResp){
                  if(newsResp.error != null) return Center(
                    child: Text(
                      newsResp.error,
                      style: AppTextStyle.error,
                    ),
                  );
                  if(newsResp.list != null && !newsResp.isLoading) return ScrollConfiguration(
                    behavior: Behavior(),
                    child: ListView.builder(
                      itemCount: newsResp.list.length,
                      itemBuilder: (context, i){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                              child: Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () => showBottomSheet(
                                      context: context,
                                      builder: (context){
                                        return Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: AppColor.black1, width: 1),
                                          ),
                                          child: SizedBox(
                                            height: 120,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    InkWell(
                                                      onTap: () => Navigator.pop(context),
                                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(25)),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(16),
                                                        child: Text(
                                                          'Отмена',
                                                          style: AppTextStyle.header,
                                                        ),
                                                      ),
                                                    ),
                                                    StoreConnector<AppState, Function()>(
                                                      converter: (store) => () => store.dispatch(subscription(newsResp.list[i].userId, newsResp.list[i].author)),
                                                      builder: (context, subscription){
                                                        return InkWell(
                                                          onTap: () => subscription(),
                                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25)),
                                                          child: Padding(
                                                            padding: EdgeInsets.all(16),
                                                            child: Text(
                                                              store.state.userResp.user.subscrUser.contains(newsResp.list[i].userId) ? 'Отписаться' : 'Оформить',
                                                              style: AppTextStyle.headerBold,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                Padding(
                                                  padding: EdgeInsets.all(16),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        'Подписка на ',
                                                        style: AppTextStyle.text,
                                                      ),
                                                      Text(
                                                        newsResp.list[i].author,
                                                        style: AppTextStyle.headerBold,
                                                        maxLines: 1,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    ),
                                    child: Icon(
                                      store.state.userResp.user.subscrUser.contains(newsResp.list[i].userId) ? Icons.bookmark : Icons.bookmark_border,
                                      color: store.state.userResp.user.subscrUser.contains(newsResp.list[i].userId) ? AppColor.red : Colors.grey,
                                      size: 25
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    newsResp.list[i].author,
                                    style: AppTextStyle.text,
                                  ),
                                  Spacer(),
                                  Text(
                                    DateFormat.yMd().format(newsResp.list[i].dateTime.toDate()),
                                    style: AppTextStyle.text,
                                  )
                                ],
                              ),
                            ),
                            AppContainer(
                              onTap: () => Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ArticlePage(
                                  title: newsResp.list[i].title,
                                  text: newsResp.list[i].text,
                                )
                              )),
                              title: newsResp.list[i].title,
                              text: newsResp.list[i].text,
                            )
                          ],
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
      ),
    );
  }
}