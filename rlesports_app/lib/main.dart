import 'package:flutter/material.dart';
import 'package:rlesports_app/pages/home.dart';

void main() {
  runApp(const RLEsports());
}

class RLEsports extends StatelessWidget {
  const RLEsports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
