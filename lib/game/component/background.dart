import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

import '../myGame.dart';

class Background extends SpriteComponent {

  Background.level1(MyGame game) {
    resize(game.screenSize);
    sprite = Sprite('bg.jpg');
  }

  void resize(Size screenSize) {
    width = screenSize.width;
    height = screenSize.height;
  }
}
