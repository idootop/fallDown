import 'dart:math';
import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:supercharged/supercharged.dart';

import '../myGame.dart';
import 'box.dart';
import 'coin.dart';

class Ban extends PositionComponent
    with HasGameRef, Tapable, ComposedComponent, Resizable {
  MyGame game;
  bool killed = false; //是否活着

  List<Box> boxs;
  List<Coin> coins;
  double positionY = 0;

  Ban(this.game, Box2DComponent box, double distance) {
    myBan(box, distance);
  }

  @override
  void update(double dt) {
    super.update(dt);
    var body = boxs.firstWhere((e) => e is Box).body; //最后一行的box
    positionY = body.viewport.getWorldToScreen(body.center).y;
  }

  randomListItem(List temp) =>
      temp.length < 1 ? null : temp[Random().nextInt(temp.length)];

  int listDistance(List<int> positions, int position) {
    int distance;
    positions.forEach((p) {
      int tempDistance = (p - position).abs();
      if (distance == null || tempDistance < distance) distance = tempDistance;
    });
    return distance == null ? 0 : distance;
  }

  int closestIndex(List<int> positions, int position) {
    int distance, closestIndex;
    positions.forEach((p) {
      int tempDistance = (p - position).abs();
      if (distance == null || tempDistance < distance) {
        distance = tempDistance;
        closestIndex = p;
      }
    });
    return closestIndex;
  }

  myBan(Box2DComponent box, double p) {
    List<int> blankPositions = [];
    double distance = p + game.topDistance;
    //创建一条障碍
    boxs = List<Box>()..length = game.boxLength;
    coins = List<Coin>()..length = game.boxLength;
    if (p == 0) {
      //第一个障碍只有中间一个缺口
      blankPositions = [((game.boxLength - 1) / 2).round()];
    } else {
      //生成随机空缺数
      int blankCounts = Random().nextInt(game.blankLength - 1) + 1; //随机空缺数
      List<int> positions = 0.rangeTo(game.boxLength - 1).toList(); //所有位置
      List(blankCounts).forEach((e) {
        //随机生成空缺位置
        int blankPosition = randomListItem(positions);
        var closest = closestIndex(blankPositions, blankPosition);
        var safe = closest == null ||
            (blankPosition > closest && closest - blankPosition > 3) ||
            (blankPosition < closest &&
                closest - blankPosition > 3 + game.blankLength);
        if (blankPosition == null || (blankPositions.length > 0 && !safe))
          return; //没有剩余的可行位置了
        for (int tempPosition
            in blankPosition.rangeTo(blankPosition + game.blankSize - 1)) {
          if (tempPosition > -1 && tempPosition < game.boxLength) {
            //可行的空缺位置
            blankPositions.add(tempPosition); //添加空缺位置
            positions.remove(tempPosition); //移除空缺位置
            //移除紧邻空缺右边3个的位置
            for (int i in tempPosition.rangeTo(tempPosition + 3)) {
              positions.remove(i);
            }
            //移除紧邻空缺左边3个的位置
            for (int i in tempPosition.rangeTo(tempPosition - 3)) {
              positions.remove(i);
            }
          }
        }
      });
    }
    //填充空缺位置左右两边
    for (int blank in blankPositions) {
      //左边
      if (blank - 1 > -1 && !blankPositions.contains(blank - 1)) {
        boxs[blank - 1] = Box.right(
            game,
            box,
            Vector2(game.tileSize * (blank - 1), distance),
            Size(game.tileSize, game.tileSize));
      }
      //右边
      if (blank + 1 < game.boxLength && !blankPositions.contains(blank + 1)) {
        boxs[blank + 1] = Box.left(
            game,
            box,
            Vector2(game.tileSize * (blank + 1), distance),
            Size(game.tileSize, game.tileSize));
      }
    }
    List<int> boxPosition = []; //其余位置填充砖块,记录砖块位置
    for (int i in 0.rangeTo(game.boxLength - 1)) {
      if (!blankPositions.contains(i) && boxs[i] == null) {
        boxs[i] = Box.center(game, box, Vector2(game.tileSize * i, distance),
            Size(game.tileSize, game.tileSize));
        boxPosition.add(i);
      }
    }
    //填充金币
    if (p != 0) {
      //生成随机空缺数
      int coinCounts = Random().nextInt(game.blankLength - 1); //随机空缺数
      List(coinCounts).forEach((e) {
        //随机生成空缺位置
        int coinPosition = randomListItem(boxPosition);
        boxPosition.remove(coinPosition); //空缺位置
        coins[coinPosition] = Coin(
            game,
            box,
            Vector2(game.tileSize * coinPosition, distance - game.tileSize),
            Size(game.tileSize, game.tileSize));
      });
    }
    //添加组件
    boxs.forEach((c) => c == null ? 0 : add(c));
    coins.forEach((c) => c == null ? 0 : add(c));
    var body = boxs.firstWhere((e) => e is Box).body; //最后一行的box
    positionY = body.viewport.getWorldToScreen(body.center).y;
  }

  void remove() {
    killed = true;
  }

  /// 判断是否可以被移除了
  bool destroy() {
    return killed;
  }
}
