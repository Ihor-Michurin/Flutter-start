import 'package:flutter/material.dart';

class AnimatedBarChart extends StatefulWidget {
  const AnimatedBarChart({super.key});

  @override
  _AnimatedBarChartState createState() => _AnimatedBarChartState();
}

class _AnimatedBarChartState extends State<AnimatedBarChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final List<double> _data = [0.2, 0.4, 0.6, 0.8];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
      setState(() {});
    });
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Bar Chart'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 200,
          child: CustomPaint(
            painter: _BarChartPainter(_data, _animation.value),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _currentIndex = (_currentIndex + 1) % _data.length;
            _data[_currentIndex] = 0.2 + 0.6 * _animation.value;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _BarChartPainter extends CustomPainter {
  final List<double> data;
  final double animationValue;

  _BarChartPainter(this.data, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = size.width / data.length;
    final barHeight = size.height * animationValue;
    final paint = Paint();

    for (int i = 0; i < data.length; i++) {
      final x = i * barWidth;
      final y = size.height * (1 - data[i]);

      paint.color = Colors.blue.shade400;
      if (i % 2 == 1) {
        paint.color = Colors.red.shade400;
      }

      canvas.drawRect(
        Rect.fromLTWH(x, y, barWidth, barHeight),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_BarChartPainter oldDelegate) =>
      animationValue != oldDelegate.animationValue;
}

void main() {
  runApp(const MaterialApp(home: AnimatedBarChart()));
}
