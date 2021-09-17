import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:monster_must_die/models/enemy.dart';
import 'package:flame/assets.dart';
import 'package:monster_must_die/widgets/unit_widget.dart';

class EnemyWidget extends Enemy {

  late SpriteAnimation enemyAnimation;
  late Sprite lifebar;
  late Images images;
  bool etatChanger=false;
  bool isStopped=false;


  //Constructors
  EnemyWidget(double x, double y, int type,this.images) : super(x, y, type){

    switch(type) {
      case 0: {
        enemyAnimation = SpriteAnimation.fromFrameData(
            images.fromCache('heheboy.png'),
            SpriteAnimationData.sequenced(
              amount: 19,
              textureSize: Vector2(700, 660),
              stepTime: 0.1,
            ));
      }
      break;

      default: {
        enemyAnimation = SpriteAnimation.fromFrameData(
            images.fromCache('fe.png'),
            SpriteAnimationData.sequenced(
              amount: 26,
              textureSize: Vector2(40, 40),
              stepTime: 0.1,
            ));
      }
      break;

    }

    lifebar=Sprite(images.fromCache('lifebarRouge.png'));

  }

  static EnemyWidget enemyWidgetRandom(double minX, double maxX, double minY, double maxY, int type,Images images){
    var rng = Random();
    double x = minX + rng.nextInt(( maxX.toInt() - minX.toInt() ) ).toDouble();
    double y = minY + rng.nextInt(( maxY.toInt() - minY.toInt() ) ).toDouble();

    return EnemyWidget(x, y, type,images);
  }


  void renderEnemy(Canvas canvas) {
    enemyAnimation
        .getSprite()
        .render(canvas, position: getPosition(), size: enemySize);
    lifebar.render(canvas, position: Vector2(getPosition().x,getPosition().y-10), size: Vector2((enemySize.x*health)/maxHealth,10));
  }

  bool isAlive(){
    return health>0?true:false;
  }

  void updateMovEnemie(double dt,double speed,UnitWidget target) {
    enemyAnimation.update(dt);
    double vectorX=target.getPosition().x-getPosition().x;
    double vectorY=target.getPosition().y-getPosition().y;

    double length=sqrt(vectorX*vectorX+vectorY*vectorY);

    double newVectorX=vectorX/length;
    double newVectorY=vectorY/length;

    setPosition(Vector2(getPosition().x+newVectorX*speed,getPosition().y+newVectorY*speed));

  }

  void attaque(double dt,UnitWidget target) {
    enemyAnimation.update(dt);
    target.health-=damage;

  }

  UnitWidget checkInRangeUnit(List<UnitWidget> uns ,Vector2 size){
    double unitX,unitY;
    double enemyX=getPosition().x+enemySize.x/2,enemyY=getPosition().y+enemySize.y/2;

    UnitWidget plusProche=UnitWidget(size.x/2, size.y+100, 0,images);
    double proximite=9999999;
    double tempProxi=0;

    for(int ii=0;ii<uns.length;ii++){
      unitX=uns[ii].getPosition().x+uns[ii].unitSize.x/2;
      unitY=uns[ii].getPosition().y+uns[ii].unitSize.y/2;

      tempProxi=sqrt(pow(unitX-enemyX,2)+pow(unitY-enemyY,2));

      if(tempProxi<=range) {
        isStopped=true;
        return uns[ii];
      }
      else{
        if(tempProxi<proximite) {
          plusProche=uns[ii];
          proximite=tempProxi;
        }
      }

    }
    isStopped=false;
    return plusProche;
  }

  void actualisationAnim(int modificateurType){
    if(etatChanger) {
      type += modificateurType;

      switch (type) {
        case 0:
          enemyAnimation=SpriteAnimation.fromFrameData(
              images.fromCache('heheboy.png'),
              SpriteAnimationData.sequenced(
                amount: 19,
                textureSize: Vector2(700, 660),
                stepTime: 0.1,
              ));
          break;
        case 1:
          enemyAnimation = SpriteAnimation.fromFrameData(
              images.fromCache('fe.png'),
              SpriteAnimationData.sequenced(
                amount: 26,
                textureSize: Vector2(40, 40),
                stepTime: 0.1,
              ));
          break;
        default:
          break;
      }
    }
  }

}