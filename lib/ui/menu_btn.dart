import 'package:flutter/material.dart';
import 'textstyle.dart';


class MenuItemBtn extends StatelessWidget{
  final String caption;
  final Function onTap;
  final Color color;

  MenuItemBtn({
    @required this.caption,
    @required this.onTap,
    @required this.color
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(

        child: Padding(
          padding: EdgeInsets.only(right: 16, bottom: 8, top: 8),
          child: Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 2, color: color))
            ),
            child: Text(
              caption,
              style: AppTextStyle.menuItems,
            ),
          )
        )
      ),
    );
  }
}