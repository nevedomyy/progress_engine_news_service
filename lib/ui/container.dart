import 'package:flutter/material.dart';
import 'package:news_service_app/ui/textstyle.dart';
import 'color.dart';


class AppContainer extends StatelessWidget{
  final Function onTap;
  final String title;
  final String text;

  AppContainer({
    @required this.onTap,
    @required this.title,
    @required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: AppTextStyle.headerBold,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    text,
                    style: AppTextStyle.text,
                    maxLines: 3,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}