import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class random extends StatefulWidget {
  int column;
  int row;

  random({Key key, this.column, this.row}) : super(key: key);

  @override
  _randomState createState() => _randomState();
}

class _randomState extends State<random> {
  List<Widget> _viewList = <Widget>[];
  var _width;
  var _height;
  int x;
  int y;
  Timer timer;
  bool isClear = false;

  @override
  void initState() {
    super.initState();

    print(widget.column);
    print(widget.row);
    // print(MediaQuery.of(context).size.width);
    randomTime();
  }

  void _initGuideData() {
    for (int i = 0; i < 5; i++) {
      _viewList.add(Container(
        width: _width / 5,
        margin: const EdgeInsets.symmetric(horizontal: 1.0),
        color: Colors.tealAccent,
        child: Text('$i'),
      ));
    }
  }

  randomTime() {
    timer = Timer.periodic(Duration(seconds: 10), (timer) {
      var rngx = new Random();
      var rngy = new Random();

      setState(() {
        isClear = false;
        x = rngx.nextInt(widget.row);
        y = rngy.nextInt(widget.column);
        print('x=$x,$y');
      });
    });
  }

  @override
  void deactivate() {
    timer.cancel();
  }

  List<Widget> demoChildren(num) {
    return List.generate(
        num,
        (i) => Center(
              child: Ink(
                decoration: const ShapeDecoration(
                  color: Colors.lightBlue,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(IconData(59677 + i, fontFamily: 'MaterialIcons')),
                  color: Colors.white,
                  onPressed: () {
                    print('點到了 $i');
                  },
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    // updateUI();
    // print(MediaQuery.of(context).size.width);
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;

    // return Scaffold(
    //   body: Container(
    //     child: Text('1235555555'),
    //   ),
    // );

    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: widget.row,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              width: (_width - 20) / widget.row,
              margin: const EdgeInsets.symmetric(horizontal: 1.0),
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: new BoxDecoration(
                        color: isClear
                            ? Colors.white
                            : index == x
                                ? Colors.blue
                                : Colors.white,
                      ),
                      child: ListView.builder(
                          itemCount: widget.column,
                          itemBuilder: (context, indexs) {
                            return Container(
                              margin: EdgeInsets.only(
                                left: 5.0,
                                right: 5.0,
                                top: 5.0,
                                bottom: 5.0,
                              ),
                              decoration: new BoxDecoration(
                                border: new Border.all(
                                    color: Color(0xFFA1A1A1), width: 1),
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0)),
                              ),
                              height: (_height - 180) / widget.column,
                              child: isClear
                                  ? Center(
                                      child: Text(''),
                                    )
                                  : indexs == y && index == x
                                      ? Center(
                                          child: Text('random'),
                                        )
                                      : Center(
                                          child: Text(''),
                                        ),
                            );
                          }),
                    ),
                  ),
                  RaisedButton(
                    color: isClear
                        ? Colors.white
                        : index == x
                            ? Colors.blue
                            : Colors.white,
                    onPressed: () {
                      setState(() {
                        isClear = true;
                      });
                    },
                    child: Text(
                      '确定',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    // return Scaffold(
    //   body: Container(
    //     child: GridView(
    //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //             crossAxisCount: 5,
    //             childAspectRatio: 1.5
    //         ),
    //         children: demoChildren(32)
    //     ),
    //   ),
    // );
  }
}
