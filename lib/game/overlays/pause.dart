import 'package:flutter/material.dart';

import '../myGame.dart';

class PauseOverlay extends StatefulWidget {
  final MyGame game;
  PauseOverlay(this.game);
  @override
  _PauseOverlayState createState() => _PauseOverlayState();
}

class _PauseOverlayState extends State<PauseOverlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black54,
        body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: widget.game.pause,
            child: Container(
              width: widget.game.screenSize.width,
              height: widget.game.screenSize.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    '游戏已暂停',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: widget.game.pause,
                    child: Text('继续',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.game.newHome,
                    child: Text('回主页',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )));
  }
}
