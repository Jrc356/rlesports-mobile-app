import 'package:flutter/material.dart';
import 'package:rlesports_app/theme/colors.dart';
import 'package:rlesports_app/theme/sizes.dart';

class RLAppBar extends StatelessWidget implements PreferredSizeWidget {
  final searchText = TextEditingController();

  RLAppBar({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      toolbarHeight: preferredSize.height,
      leading: const Icon(Icons.menu, color: AppColors.white, size: 40),
      title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            controller: searchText,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchText.clear();
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none),
          ),
        ),
      ),
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
