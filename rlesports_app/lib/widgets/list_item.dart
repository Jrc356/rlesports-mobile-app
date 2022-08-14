import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rlesports_app/widgets/clickable_item.dart';
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
  @override
  Widget build(BuildContext context) {
    // TODO: I want this animated
    return ClickableItem(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => widget.pageToPush,
          ),
        );
      }),
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
    );
  }
}
