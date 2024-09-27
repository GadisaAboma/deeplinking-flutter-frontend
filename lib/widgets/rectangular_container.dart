import 'package:flutter/material.dart';

class RectangularContainer extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final double? width;
  final double paddingVertical;
  final double marginVertical;

  const RectangularContainer(
      {required this.child,
      this.width,
      this.paddingVertical = 15,
      this.marginVertical = 15,
      this.backgroundColor = Colors.white,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: marginVertical, horizontal: 7),
      decoration: BoxDecoration(
        color: backgroundColor,
        // shape: BoxShape.circle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(-1, 4), // Horizontal and Vertical offset
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }
}
