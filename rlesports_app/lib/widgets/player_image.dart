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
          // player.imageUrl will always be something as there is a default
          image: Image.network(player.imageUrl.toString()).image,
        ),
      ),
    );
  }
}
