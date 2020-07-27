import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../myGame.dart';

class Setting extends StatefulWidget {
  final MyGame game;
  Setting(this.game);
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: null,
          child: Container(
              width: widget.game.screenSize.width,
              height: widget.game.screenSize.height,
              child: Column(
                children: <Widget>[
                  Expanded(flex: 1, child: SizedBox()),
                  Text(
                    '操作模式',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                  GestureDetector(
                    onTap: () {
                      widget.game.useGravity =
                          kIsWeb ? false : !widget.game.useGravity;
                      setState(() {});
                    },
                    child: Text(
                      widget.game.useGravity ? '👉重力感应👈' : '👉点击屏幕👈',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                  GestureDetector(
                    onTap: widget.game.setting,
                    child: Image.asset(
                      'assets/images/done.png',
                      width: 220,
                      height: 120,
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                ],
              )),
        ));
  }
}
