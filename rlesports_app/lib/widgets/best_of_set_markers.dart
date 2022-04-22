import 'package:flutter/material.dart';
import 'package:rlesports_app/theme/colors.dart';

class BestOfSetMarkers extends StatelessWidget {
  final Color color;
  final int bestOf;
  final int hasWon;
  final bool reverse;
  const BestOfSetMarkers({
    Key? key,
    required this.color,
    required this.hasWon,
    this.bestOf = 5,
    this.reverse = false,
  }) : super(key: key);

  Container makeMarker(bool enabled) {
    return Container(
      decoration: BoxDecoration(
        color: enabled ? color : AppColors.whiteGradient_1,
        border: Border.all(color: AppColors.matteGrey, width: 1.5),
      ),
      height: 13.28,
      width: 26.56,
    );
  }

  @override
  Widget build(BuildContext context) {
    int bo = (bestOf / 2).ceil();

    List<Container> markers = <Container>[];
    if (reverse) {
      for (int i = 0; i < bo; i++) {
        markers.insert(0, makeMarker(i < hasWon));
      }
    } else {
      for (int i = 0; i < bo; i++) {
        markers.add(makeMarker(i < hasWon));
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: markers,
    );
  }
}
