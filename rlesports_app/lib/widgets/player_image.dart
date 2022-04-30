import 'package:flutter/material.dart';
import 'package:rlesports_app/models/player.dart';
import 'package:rlesports_app/theme/colors.dart';

class PlayerImage extends StatelessWidget {
  final Player player;
  final double width;
  final double height;
  final bool useShadow;
  const PlayerImage({
    Key? key,
    required this.player,
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
          image: Image.network(player.imageUrl ??
                  "https://media.sketchfab.com/models/9910f0a5d158425bbc7deb60c7a81f69/thumbnails/14ce0f826a6f4e3d9f2fb5921cd98a74/c5a09b29d7f649559972363859e7c80f.jpeg")
              .image,
        ),
      ),
    );
  }
}
