import 'package:flutter/material.dart';
import 'package:rlesports_app/theme/colors.dart';

class EntityImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final bool useShadow;
  const EntityImage({
    Key? key,
    required this.url,
    this.width = 53.13,
    this.height = 53.13,
    this.useShadow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Player image
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
        boxShadow: useShadow
            ? const <BoxShadow>[
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(0, 5),
                ),
              ]
            : [],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(url),
        ),
      ),
    );
  }
}
