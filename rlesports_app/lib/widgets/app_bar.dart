import 'package:flutter/material.dart';
import 'package:rlesports_app/theme/colors.dart';
import 'package:rlesports_app/theme/sizes.dart';
import 'package:rlesports_app/widgets/search_bar.dart';

class RLAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool useBackButton;
  final bool useSearchBar;

  const RLAppBar({
    Key? key,
    this.useBackButton = false,
    this.useSearchBar = true,
  }) : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context) {
    IconButton leadingIcon;

    // Decide which leading icon to use
    // if specified, use the back button
    if (useBackButton) {
      leadingIcon = IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.white,
          size: 40,
        ),
        onPressed: () => {Navigator.pop(context)},
      );
    } else {
      leadingIcon = IconButton(
        icon: const Icon(
          Icons.menu,
          color: AppColors.white,
          size: 40,
        ),
        onPressed: () => {
          // TODO: open app tray
          print("Menu tapped"),
        },
      );
    }

    return AppBar(
      centerTitle: true,
      toolbarHeight: preferredSize.height,
      leading: leadingIcon,
      title: useSearchBar ? const SearchBar() : null,
      backgroundColor: AppColors.matteGrey,
      shape: const Border(
        bottom: BorderSide(
          color: AppColors.outlines,
          width: AppSizes.outlineWidth,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
