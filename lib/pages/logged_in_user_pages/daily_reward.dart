import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoto/pages/logged_in_user_pages/account_page.dart';
import 'package:tokoto/pages/logged_in_user_pages/update_points.dart';

class SpinTheWheel extends StatefulWidget {
  @override
  _SpinTheWheelState createState() => _SpinTheWheelState();
}

class _SpinTheWheelState extends State<SpinTheWheel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final Random _random = Random();
  double _currentAngle = 0.0;
  final List<String> _options = ['100 P', '200 P', '300 P', '500 P'];
  bool _canSpin = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.decelerate);
    _loadLastSpinTime();
  }

  Future<void> _loadLastSpinTime() async {
    final prefs = await SharedPreferences.getInstance();
    final lastSpinTime = prefs.getInt('lastSpinTime') ?? 0;
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    if (currentTime - lastSpinTime < 86400000) { // 24 hours in milliseconds
      setState(() {
        _canSpin = false;
      });
    }
  }

  Future<void> _saveSpinTime() async {
    final prefs = await SharedPreferences.getInstance();
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    await prefs.setInt('lastSpinTime', currentTime);
  }

  void _spinWheel() {
    if (!_canSpin) return;

    final double randomAngle = _random.nextDouble() * 2 * pi;
    setState(() {
      _currentAngle = randomAngle;
      _canSpin = false;
    });
    _controller.reset();
    _controller.forward().then((_) {
      _showResult();
      _saveSpinTime();
    });
  }

  void _showResult() {
    final int selectedIndex = (_currentAngle / (2 * pi / _options.length)).floor() % _options.length;
    final String result = _options[selectedIndex];
    // final newPoints = ;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Congratulations!'),
        content: Text('You got $result'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return UpdatePoints(spin_res: result,);
                  }));
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spin the Wheel'.tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _currentAngle * _animation.value,
                  child: child,
                );
              },
              child: CustomPaint(
                size: Size(300, 300),
                painter: WheelPainter(_options),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, // foreground (text) color
                  backgroundColor: Colors.yellow, // background color
                ),
              onPressed: _canSpin ? _spinWheel : null,
              child: Text(_canSpin ? 'Spin'.tr : 'Come back tomorrow!'),
            ),
          ],
        ),
      ),
    );
  }
}

class WheelPainter extends CustomPainter {
  final List<String> options;
  WheelPainter(this.options);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    final double anglePerOption = 2 * pi / options.length;

    for (int i = 0; i < options.length; i++) {
      paint.color = i.isEven ? Colors.blue : Colors.pink;
      _drawSlice(canvas, size, paint, i * anglePerOption, anglePerOption);
      _drawText(canvas, size, options[i], i * anglePerOption + anglePerOption / 2);
    }
  }

  void _drawSlice(Canvas canvas, Size size, Paint paint, double startAngle, double sweepAngle) {
    final rect = Rect.fromCenter(center: size.center(Offset.zero), width: size.width, height: size.height);
    canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
  }

  void _drawText(Canvas canvas, Size size, String text, double angle) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: TextStyle(color: Colors.white, fontSize: 18)),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final offset = Offset(
      size.width / 2 + cos(angle) * size.width / 2.5 - textPainter.width / 2,
      size.height / 2 + sin(angle) * size.height / 2.5 - textPainter.height / 2,
    );

    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    textPainter.paint(canvas, Offset.zero);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
