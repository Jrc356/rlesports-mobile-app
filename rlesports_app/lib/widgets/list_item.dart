import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rlesports_app/theme/colors.dart';
import 'package:rlesports_app/widgets/entity_image.dart';

const int maxLength = 20;

class ListItem extends StatefulWidget {
  final String imageUrl;
  final String text;
  final Widget pageToPush;

  const ListItem({
    Key? key,
    required this.imageUrl,
    required this.text,
    required this.pageToPush,
  }) : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    // TODO: I want this animated
    return GestureDetector(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => widget.pageToPush,
          ),
        );
      }),
      child: Container(
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
              EntityImage(url: widget.imageUrl),
              Padding(
                // Player name and team
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  widget.text.length < maxLength
                      ? widget.text
                      : widget.text.substring(
                            0,
                            min(widget.text.length, maxLength),
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
      ),
    );
  }
}
