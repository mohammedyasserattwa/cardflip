import 'package:cardflip/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// main() async {
//   runApp(MaterialApp(
//     home: Scaffold(
//       body: Center(
//         child: LoadingWidget(),
//       ),
//     ),
//   ));
// }

class LoadingWidget extends StatefulWidget {
  Color color;
  bool transparent = false;
  LoadingWidget({this.color = Colors.black, this.transparent = false});
  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController1;
  late Animation<double> _rotationAnimation1;

  @override
  void initState() {
    super.initState();
    _animationController1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _rotationAnimation1 = Tween<double>(
      begin: 0,
      end: 360,
    ).animate(_animationController1)
      ..addListener(() {
        setState(() {});
      });
    _animationController1.repeat();
  }

  @override
  void dispose() {
    _animationController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: (widget.transparent)?Colors.transparent:widget.color.withOpacity(0.3),
      child: Center(
          child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _rotationAnimation1,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "Images/cards/loadingpage/orange_card_loading.png"),
                    ),
                  ),
                  width: 50,
                  height: 75,
                ),
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationAnimation1.value * 0.0174533,
                    child: child,
                  );
                },
              ),
              SizedBox(width: 30),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _rotationAnimation1,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "Images/cards/loadingpage/pink_card_loading.png"),
                    ),
                  ),
                  width: 50,
                  height: 75,
                ),
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationAnimation1.value * 0.0174533,
                    child: child,
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 30),
              AnimatedBuilder(
                animation: _rotationAnimation1,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "Images/cards/loadingpage/blue_card_loading.png"),
                    ),
                  ),
                  width: 50,
                  height: 75,
                ),
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationAnimation1.value * 0.0174533,
                    child: child,
                  );
                },
              ),
            ],
          ),
        ],
      )),
    );
  }
}
