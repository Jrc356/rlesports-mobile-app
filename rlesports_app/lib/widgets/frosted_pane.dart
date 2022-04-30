import 'package:flutter/material.dart';
import 'package:rlesports_app/theme/colors.dart';

class FrostedPane extends StatelessWidget {
  final Widget child;
  const FrostedPane({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: .9 * MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.navBarActiveIconBorder,
          width: 0.75,
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.whiteGradient_1.withOpacity(0.5),
            AppColors.whiteGradient_2.withOpacity(0.5),
          ],
        ),
      ),
      child: child,
    );
  }
}
