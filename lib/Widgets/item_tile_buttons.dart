import 'package:flutter/material.dart';

class ItemTileButtons extends StatelessWidget {
  const ItemTileButtons(
      {Key? key,
      required this.addItem,
      required this.removeItem,
      required this.count})
      : super(key: key);

  final VoidCallback addItem;
  final VoidCallback removeItem;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(right: 16.0),
        child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                  opacity: Tween<double>(begin: 0, end: 1).animate(animation),
                  child: child);
            },
            child: Row(
              key: ValueKey<bool>(count == 0),
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (count > 0)
                  IconButton(
                      iconSize: 16.0,
                      splashRadius: 24.0,
                      color: Theme.of(context).textTheme.caption!.color,
                      onPressed: removeItem,
                      icon: const Icon(Icons.remove)),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: Text(
                    key: ValueKey<int>(count),
                    count > 0 ? '$count' : '',
                  ),
                ),
                if (count > 0)
                  IconButton(
                      iconSize: 16.0,
                      splashRadius: 24.0,
                      onPressed: addItem,
                      color: Theme.of(context).textTheme.caption!.color,
                      icon: const Icon(Icons.add)),
                if (count == 0)
                  TextButton(
                      onPressed: addItem,
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(16.0)),
                      child: const Text("Add"))
              ],
            )));
  }
}
