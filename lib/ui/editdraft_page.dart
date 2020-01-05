import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../middleware/thunk.dart';
import '../store/state.dart';
import 'textstyle.dart';
import 'behavior.dart';
import 'color.dart';


class EditDraftPage extends StatefulWidget {
  final int index;
  final String draftId;
  final String title;
  final String text;

  EditDraftPage({
    @required this.index,
    @required this.draftId,
    @required this.title,
    @required this.text,
  });

  @override
  _EditDraftPageState createState() => _EditDraftPageState(index, draftId, title, text);
}

class _EditDraftPageState extends State<EditDraftPage>{
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final int index;
  final String draftId;
  final String title;
  final String text;

  _EditDraftPageState(this.index, this.draftId, this.title, this.text);

  @override
  void initState() {
    super.initState();
    _titleController.text = title;
    _textController.text = text;
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.white,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              StoreConnector<AppState, Function()>(
                converter: (store) => () => store.dispatch(publicDraft(index, draftId, _titleController.text, _textController.text)),
                builder: (context, publicDraft){
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
                        if(_titleController.text.isEmpty || _textController.text.isEmpty) return;
                        publicDraft();
                      },
                      borderRadius: BorderRadius.circular(25),
                      highlightColor: Colors.black12,
                      splashColor: Colors.black12,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'Опубликовать',
                          style: AppTextStyle.btn,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              Expanded(
                child: ScrollConfiguration(
                  behavior: Behavior(),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextField(
                          controller: _titleController,
                          style: AppTextStyle.headerBold,
                          cursorColor: AppColor.red,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          maxLength: null,
                          decoration: InputDecoration.collapsed(
                            hintText: 'Заголовок',
                            hintStyle: AppTextStyle.headerBold,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _textController,
                          style: AppTextStyle.text,
                          cursorColor: AppColor.red,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          maxLength: null,
                          decoration: InputDecoration.collapsed(
                            hintText: 'Текст',
                            hintStyle: AppTextStyle.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
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
                        'Закрыть',
                        style: AppTextStyle.btn,
                      ),
                    ),
                  ),
                  StoreConnector<AppState, Function()>(
                    converter: (store) => () => store.dispatch(saveDraft(index, draftId, _titleController.text, _textController.text)),
                    builder: (context, saveDraft){
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
                            if(_titleController.text.isEmpty || _textController.text.isEmpty) return;
                            saveDraft();
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}