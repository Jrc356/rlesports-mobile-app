import 'package:flutter/material.dart';
import 'package:rlesports_app/theme/colors.dart';

class FrostedPane extends StatelessWidget {
  final Widget child;
  final double topMargin, bottomMargin, leftMargin, rightMargin;
  final double topPadding, bottomPadding, leftPadding, rightPadding;

  const FrostedPane({
    Key? key,
    required this.child,
    this.topMargin = 5,
    this.bottomMargin = 5,
    this.leftMargin = 10,
    this.rightMargin = 10,
    this.topPadding = 10,
    this.bottomPadding = 10,
    this.rightPadding = 0,
    this.leftPadding = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: topMargin,
        bottom: bottomMargin,
        left: leftMargin,
        right: rightMargin,
      ),
      padding: EdgeInsets.only(
        top: topPadding,
        bottom: bottomPadding,
        left: leftPadding,
        right: rightPadding,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.navBarActiveIconBorder,
          width: 0.75,
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.whiteGradient_1.withOpacity(0.5),
            AppColors.whiteGradient_2.withOpacity(0.5),
          ],
        ),
      ),
      child: child,
    );
  }
}
