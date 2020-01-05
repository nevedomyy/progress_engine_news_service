import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../middleware/thunk.dart';
import '../store/state.dart';
import '../store/storage.dart';
import 'dart:math';
import 'textstyle.dart';
import 'color.dart';


class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>{
  final List<TextEditingController> _controller = List.generate(5, (_) =>  TextEditingController());
  final List<String> _label = ['Логин', 'Пароль', 'Имя', 'Мейл', 'Телефон'];
  String _userId;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async{
    _userId = 'user_' + Random().nextInt(999999).toString();
    storage.write(key: 'userId', value: _userId);
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
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Регистрация',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(25),
                    highlightColor: Colors.black12,
                    splashColor: Colors.black12,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Отмена',
                        style: AppTextStyle.btn,
                      ),
                    ),
                  ),
                  StoreConnector<AppState, Function()>(
                    converter: (store) => () => store.dispatch(registration(
                      _userId,
                      _controller[0].text,
                      _controller[1].text,
                      _controller[2].text,
                      _controller[3].text,
                      _controller[4].text,
                    )),
                    builder: (context, registration){
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
                            registration();
                          },
                          borderRadius: BorderRadius.circular(25),
                          highlightColor: Colors.black12,
                          splashColor: Colors.black12,
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              'Готово',
                              style: AppTextStyle.btn,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}