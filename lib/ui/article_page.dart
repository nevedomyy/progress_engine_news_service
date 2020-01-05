import 'package:flutter/material.dart';
import 'textstyle.dart';
import 'behavior.dart';
import 'color.dart';


class ArticlePage extends StatelessWidget{
  final String title;
  final String text;

  ArticlePage({
    @required this.title,
    @required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.white,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ScrollConfiguration(
                  behavior: Behavior(),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Text(
                          title,
                          style: AppTextStyle.headerBold,
                        ),
                        SizedBox(height: 10),
                        Text(
                          text,
                          style: AppTextStyle.text,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Ink(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  boxShadow: [
                    BoxShadow(offset: Offset(2.0, 4.0), blurRadius: 6.0, color: AppColor.shadow)
                  ]
                ),
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(25),
                  highlightColor: Colors.black12,
                  splashColor: Colors.black12,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Закрыть',
                      style: AppTextStyle.btn,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}