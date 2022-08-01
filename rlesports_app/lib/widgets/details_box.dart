import 'package:flutter/material.dart';
import 'package:rlesports_app/theme/colors.dart';

class DetailsBox extends StatelessWidget {
  final String title;
  final Map<String, String> details;
  const DetailsBox({
    Key? key,
    required this.title,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: AppColors.whiteGradient,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 75),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              // Player Alias
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
              // Other player details
              ...details.entries
                  .map(
                    (entry) => detail(entry),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget detail(MapEntry<String, String> entry) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 10,
    ),
    child: Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(
              text: "${entry.key}: ",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: entry.value,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
