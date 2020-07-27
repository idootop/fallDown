import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../myGame.dart';

class Home extends StatefulWidget {
  final MyGame game;
  Home(this.game);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                  Expanded(flex: 2, child: SizedBox()),
                  Text(
                    '坠 落',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 64,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                  // GestureDetector(
                  //   onTap: widget.game.newGame,
                  //   child: Image.asset(
                  //     'assets/images/start.png',
                  //     width: 128,
                  //     height: 128,
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: widget.game.newGame,
                    child: Text(
                      '开始游戏',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        iconSize: 48,
                        icon: Icon(
                          Icons.info,
                          color: Colors.white,
                          size: 48,
                        ),
                        onPressed: () async{
                          //关于
                          launchURL(String url) async {
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          }
                          await launchURL('http://v.idoo.top/web/fallDown/about.html');
                        },
                      ),
                      IconButton(
                        iconSize: 48,
                        icon: Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 48,
                        ),
                        onPressed: widget.game.setting,
                      )
                    ],
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                ],
              )),
        ));
  }
}
