import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../store/state.dart';
import '../model/models.dart';
import 'behavior.dart';
import 'textstyle.dart';
import 'color.dart';


class SubscriptionsPage extends StatelessWidget{
  final String title;

  SubscriptionsPage(this.title);

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
              child: StoreConnector<AppState, UserResp>(
                converter: (store) => store.state.userResp,
                builder: (context, userResp){
                  if(userResp.error != null) return Center(
                    child: Text(
                      userResp.error,
                      style: AppTextStyle.error,
                    ),
                  );
                  if(userResp.user != null && !userResp.isLoading) return ScrollConfiguration(
                    behavior: Behavior(),
                    child: ListView.builder(
                      itemCount: userResp.user.subscrUser.length,
                      itemBuilder: (context, i){
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(25)),
                                boxShadow: [
                                  BoxShadow(color: AppColor.shadow, blurRadius: 3, offset: Offset(1, 2))
                                ]
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              child: Text(
                                userResp.user.subscrAuthor[i],
                                style: AppTextStyle.headerBold,
                              ),
                            ),
                          ),
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