import 'package:flutter/material.dart';
import 'package:rlesports_app/theme/colors.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      // Search bar
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
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
