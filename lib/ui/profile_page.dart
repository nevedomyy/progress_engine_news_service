import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../middleware/thunk.dart';
import '../store/state.dart';
import '../store/store.dart';
import 'textstyle.dart';
import 'color.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>{
  final List<String> _label = ['Логин', 'Пароль', 'Имя', 'Мейл', 'Телефон'];
  List<TextEditingController> _controller;

  @override
  void initState() {
    super.initState();
    _controller = List.generate(5, (_) =>  TextEditingController());
    _controller[0].text = store.state.userResp.user.login;
    _controller[1].text = store.state.userResp.user.passw;
    _controller[2].text = store.state.userResp.user.name;
    _controller[3].text = store.state.userResp.user.mail;
    _controller[4].text = store.state.userResp.user.phone;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.forEach((controller) => controller.dispose());
  }

  Widget _textField(int i){
    return Padding(
        padding: EdgeInsets.only(bottom: 12),
        child: TextField(
          controller: _controller[i],
          style: AppTextStyle.textField,
          cursorColor: AppColor.red,
          decoration: InputDecoration(
            labelText: _label[i],
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Профиль',
            style: AppTextStyle.title,
          ),
          SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25)),
                boxShadow: [
                  BoxShadow(color: AppColor.shadow, blurRadius: 3, offset: Offset(1, 2))
                ]
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(5, (i) => _textField(i)),
              ),
            ),
          ),
          Spacer(),
          Center(
            child: StoreConnector<AppState, Function()>(
              converter: (store) => () => store.dispatch(saveUser(
                _controller[0].text,
                _controller[1].text,
                _controller[2].text,
                _controller[3].text,
                _controller[4].text,
                List.from(store.state.userResp.user.subscrUser),
                List.from(store.state.userResp.user.subscrAuthor)
              )),
              builder: (context, saveUser){
                return Ink(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      boxShadow: [
                        BoxShadow(offset: Offset(2.0, 4.0), blurRadius: 6.0, color: AppColor.shadow)
                      ]
                  ),
                  child: InkWell(
                    onTap: () {
                      if(_controller[0].text.isEmpty || _controller[1].text.isEmpty || _controller[2].text.isEmpty) return;
                      saveUser();
                    },
                    borderRadius: BorderRadius.circular(25),
                    highlightColor: Colors.black12,
                    splashColor: Colors.black12,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Сохранить',
                        style: AppTextStyle.btn,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16)
        ],
      ),
    );
  }
}