import 'package:flutter/material.dart';

class SearchItemsAction extends StatelessWidget {
  const SearchItemsAction(
      {Key? key, required this.showSearchBar, required this.toggleSearchBar})
      : super(key: key);

  final bool showSearchBar;
  final VoidCallback toggleSearchBar;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(right: 4.0),
        child: IconButton(
            onPressed: toggleSearchBar,
            icon: Icon(
              (showSearchBar) ? Icons.close : Icons.search,
              size: 24.0,
            )));
  }
}
