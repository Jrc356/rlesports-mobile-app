import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rlesports_app/theme/colors.dart';
import 'package:rlesports_app/widgets/entity_image.dart';

const int maxLength = 20;

class ListItem extends StatelessWidget {
  final String imageUrl;
  final String text;

  const ListItem({
    Key? key,
    required this.imageUrl,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5), //color of shadow
            spreadRadius: 2, //spread radius
            blurRadius: 7, // blur radius
            offset: const Offset(1, 3), // changes position of shadow
          ),
        ],
        gradient: AppColors.whiteGradient,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            EntityImage(url: imageUrl),
            Padding(
              // Player name and team
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                text.length < maxLength
                    ? text
                    : text.substring(
                          0,
                          min(text.length, maxLength),
                        ) +
                        "...",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Align(
              // favorite icon
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
