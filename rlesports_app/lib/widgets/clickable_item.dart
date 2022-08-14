import 'package:flutter/material.dart';
import 'package:rlesports_app/theme/colors.dart';

class ClickableItem extends StatelessWidget {
  final Widget child;
  final bool isClickable;
  final double? height;
  final Alignment alignment;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final void Function()? onTap;

  const ClickableItem({
    Key? key,
    required this.child,
    this.isClickable = true,
    this.height = 106.25,
    this.alignment = Alignment.center,
    this.margin = const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxShadow shadow = BoxShadow(
      color: Colors.black.withOpacity(0.5),
      spreadRadius: 1,
      blurRadius: 5,
      offset: const Offset(5, 8),
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: alignment,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(),
          boxShadow: isClickable ? [shadow] : [],
          gradient: AppColors.whiteGradient,
        ),
        child: child,
      ),
    );
  }
}
