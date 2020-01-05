import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../middleware/thunk.dart';
import '../store/state.dart';
import '../model/models.dart';
import 'registration_page.dart';
import 'textstyle.dart';
import 'color.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _loginController.dispose();
    _passwController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColor.black1, AppColor.black2]
          )
        ),
        child: Column(
          children: <Widget>[
            Spacer(flex: 1),
            SizedBox.fromSize(
              size: Size.square(width*2/3),
              child: SvgPicture.asset('assets/pen.svg', color: AppColor.red),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(45)),
                color: Colors.white.withOpacity(0.05)
              ),
              child: FractionallySizedBox(
                widthFactor: 0.7,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _loginController,
                    cursorColor: AppColor.red,
                    style: AppTextStyle.login,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Логин',
                      hintStyle: AppTextStyle.login,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                  color: Colors.white.withOpacity(0.05)
              ),
              child: FractionallySizedBox(
                widthFactor: 0.7,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _passwController,
                    cursorColor: AppColor.red,
                    style: AppTextStyle.login,
                    obscureText: true,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Пароль',
                      hintStyle: AppTextStyle.login,
                    ),
                  ),
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) => RegistrationPage()
                    )),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      child: Text(
                        'Регистрация',
                        style: AppTextStyle.registration,
                      ),
                    ),
                  ),
                  StoreConnector<AppState, Function(String login, String passw)>(
                    converter: (store) => (login, passw) => store.dispatch(authenticate(login, passw)),
                    builder: (context, authenticate){
                      return GestureDetector(
                        onTap: () => authenticate(_loginController.text, _passwController.text),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          child: Text(
                            'Войти',
                            style: AppTextStyle.enter,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: StoreConnector<AppState, UserResp>(
                  converter: (store) => store.state.userResp,
                  builder: (context, userResp){
                    if(userResp.isLoading) return CircularProgressIndicator();
                    if(userResp.error != null) return Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        userResp.error,
                        style: AppTextStyle.error,
                      ),
                    );
                    return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
