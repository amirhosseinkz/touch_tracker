import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Touch Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double circleRadius = 0.15;
  double left = Get.width * 0.5 - Get.width * 0.15;
  double top = Get.height * 0.5 - Get.height * 0.15;

  final Color topColor = Colors.yellow;
  final Color middleColor = Colors.blue;
  final Color bottomColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            // Update the position of the circle based on finger movement
            left = details.localPosition.dx - Get.width * circleRadius;

            // Ensure the circle stays within the screen bounds vertically
            top = details.localPosition.dy - Get.height * circleRadius;
            top = top.clamp(0.0, Get.height - Get.height * 2 * circleRadius);
          });
        },
        child: Container(
          width: Get.width,
          height: Get.height,
          color: Colors.white,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                // Update the position of the circle based on user interaction
                left: left,
                top: top,
                child: Container(
                  width: Get.width * circleRadius * 2,
                  height: Get.height * circleRadius * 2,
                  decoration: BoxDecoration(
                    color: top == 0.0
                        ? topColor
                        : top == Get.height - Get.height * 2 * circleRadius
                        ? bottomColor
                        : middleColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
