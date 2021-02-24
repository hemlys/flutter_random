import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_view/random.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textEditingController;
  TextEditingController _textRowEditingController;

  // FocusNode _focus = new FocusNode();

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _textEditingController.addListener(() {
      setState(() {});
    });
    _textRowEditingController = TextEditingController();
    _textRowEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _textRowEditingController.dispose();
  }

  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Container(
    //     child: ListView.builder(
    //       itemCount: _viewList.length,
    //       scrollDirection: Axis.horizontal,
    //       itemBuilder: (context, index) {
    //         return _viewList[index];
    //       },
    //     ),
    //   ),
    // );
    return Scaffold(
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: 20.0,
                  right: 0.0,
                  top: 0.0,
                  bottom: 0.0,
                ),
                child: Text(
                  'column',
                  textAlign: TextAlign.left,
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 0.0,
                    bottom: 0.0,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0x59A1A1A1),
                    borderRadius: BorderRadius.all(Radius.circular(
                      10.0,
                    )),
                  ),
                  child: TextField(
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2)
                    ],
                    //只允许输入数字
                    textAlign: TextAlign.center,
                    keyboardAppearance: Brightness.light,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    // focusNode: _focus,
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: '請輸入大於0的數字',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      contentPadding: EdgeInsets.only(
                        top: 5.0,
                        // bottom: 2.0,
                      ),
                      border: InputBorder.none,
                    ),
                    onSubmitted: (value) {},
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: 20.0,
                  right: 0.0,
                  top: 0.0,
                  bottom: 0.0,
                ),
                child: Text(
                  'row',
                  textAlign: TextAlign.left,
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0x59A1A1A1),
                    borderRadius: BorderRadius.all(Radius.circular(
                      10.0,
                    )),
                  ),
                  child: TextField(
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2)
                    ],
                    textAlign: TextAlign.center,
                    keyboardAppearance: Brightness.light,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    // focusNode: _focus,
                    controller: _textRowEditingController,
                    decoration: InputDecoration(
                      hintText: '請輸入大於0的數字',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      contentPadding: EdgeInsets.only(
                        top: 5.0,
                        // bottom: 2.0,
                      ),
                      border: InputBorder.none,
                    ),
                    onSubmitted: (value) {},
                  ),
                ),
              ),
            ],
          ),
          RaisedButton(
            child: Text('確認'),
            onPressed: () {
              if (_textEditingController.text.trim().length == 0 ||
                  _textRowEditingController.text.trim().length == 0 ||
                  int.parse(_textEditingController.text) < 1 ||
                  int.parse(_textRowEditingController.text) < 1) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                          title: new Text(
                            'error',
                          ),
                          content: new Text(
                            '請輸入大於0的數字',
                          ),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              child: Text(
                                'ok',
                              ),
                              onPressed: () => Navigator.of(context).pop(false),
                            ),
                          ],
                        ));
              } else {
                int columnnum = int.parse(_textEditingController.text);
                int rownnum = int.parse(_textRowEditingController.text);
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => random(
                            column: columnnum,
                            row: rownnum,
                          )),
                );
              }
            },
          ),
        ],
      )),
    );
  }
}
