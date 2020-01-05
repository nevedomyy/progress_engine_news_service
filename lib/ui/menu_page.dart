import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../middleware/thunk.dart';
import '../actions/actions.dart';
import '../store/store.dart';
import '../store/state.dart';
import '../store/storage.dart';
import 'menu_btn.dart';
import 'news_page.dart';
import 'subscriptions_page.dart';
import 'drafts_page.dart';
import 'publications_page.dart';
import 'profile_page.dart';
import 'textstyle.dart';
import 'color.dart';


class MenuPage extends StatefulWidget {
   @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with TickerProviderStateMixin{
  final List<String> _menuItems = ['Новости', 'Подписки', 'Черновики', 'Публикации', 'Профиль'];
  final _actions = [getNews(), null, getDrafts(), getPublications(), null];
  AnimationController _animationController;
  Animation _animation;
  Animation _animateIcon;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200)
    )..addListener((){setState(() {});});
    _animation = Tween(
        begin: 0.0,
        end: 0.5
    ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut
    ));
    _animateIcon = Tween(
      begin: 0.0,
      end: 1.0
    ).animate(_animationController);
    store.dispatch(getNews());
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Material(
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            color: AppColor.black2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SafeArea(
                  child: StoreConnector<AppState, Function()>(
                    converter: (store) => () => store.dispatch(LogOut()),
                    builder: (context, logOut){
                      return GestureDetector(
                        onTap: (){
                          logOut();
                          storage.delete(key: 'userId');
                          Navigator.pushReplacementNamed(context, 'loginPage');
                        },
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Выход',
                            style: AppTextStyle.enter,
                          ),
                        ),
                      );
                    },
                  )
                ),
                Spacer(flex: 2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(5, (i) => StoreConnector<AppState, Function()>(
                    converter: (store) => () => store.dispatch(_actions[i]),
                    builder: (context, function){
                      return MenuItemBtn(
                        onTap: (){
                          function();
                          _pageIndex = i;
                          _animationController.reverse();
                        },
                        caption: _menuItems[i],
                        color: _pageIndex == i ? AppColor.red : Colors.transparent,
                      );
                    },
                  )),
                ),
                Spacer(flex: 1),
              ],
            )            
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) => Transform.translate(
              offset: Offset(-_animation.value*width, 0),
              child: Container(
                width: width*0.97,
                color: AppColor.white,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: IndexedStack(
                      index: _pageIndex,
                      children: <Widget>[
                        NewsPage(_menuItems[0]),
                        SubscriptionsPage(_menuItems[1]),
                        DraftsPage(_menuItems[2]),
                        PublicationsPage(_menuItems[3]),
                        ProfilePage()
                      ],
                    )
                  )
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: (){
                if(_animationController.isCompleted) _animationController.reverse();
                else _animationController.forward();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.black2,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomLeft: Radius.circular(25))
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _animateIcon,
                    color: AppColor.red,
                    size: 25,
                  ),
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}