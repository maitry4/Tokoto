import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoto/components/custom_button.dart';


class TapTheTargetHomePage extends StatefulWidget {
  @override
  _TapTheTargetHomePageState createState() => _TapTheTargetHomePageState();
}

class _TapTheTargetHomePageState extends State<TapTheTargetHomePage> {
  Random random = Random();
  double targetX = 0.0;
  double targetY = 0.0;
  int score = 0;
  bool gameStarted = false;
  int timeLeft = 30;
  Timer? gameTimer;

  void startGame() {
    setState(() {
      score = 0;
      gameStarted = true;
      timeLeft = 30;
      moveTarget();
      gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (timeLeft > 0) {
          setState(() {
            timeLeft--;
          });
        } else {
          timer.cancel();
          setState(() {
            gameStarted = false;
          });
        }
      });
    });
  }

  void moveTarget() {
    setState(() {
      targetX = random.nextDouble() * 300;
      targetY = random.nextDouble() * 600;
    });
  }

  void onTapTarget() {
    if (gameStarted) {
      setState(() {
        score++;
        moveTarget();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tap the Target!'.tr+'👆😊'),
      ),
      body: Stack(
        children: [
          Positioned(
            left: targetX,
            top: targetY,
            child: GestureDetector(
              onTap: onTapTarget,
              child: Container(
                width: 50,
                height: 50,
                child: Center(child: Text("Tap!!".tr, style: TextStyle(color: Colors.white),)),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          if (!gameStarted)
            Center(
              child: CustomButtton(
                onTap: startGame,
                text: 'Start Game'.tr,
              ),
            ),
          Positioned(
            top: 50,
            left: 20,
            child: Text(
              'Score'.tr+': $score',
              style: TextStyle(fontSize: 24),
            ),
          ),
          Positioned(
            top: 80,
            left: 20,
            child: Text(
              'Time Left'.tr+': $timeLeft',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }
}
