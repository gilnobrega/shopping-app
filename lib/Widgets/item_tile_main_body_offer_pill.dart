import 'package:flutter/material.dart';

class ItemTileMainBodyOfferPill extends StatelessWidget {
  const ItemTileMainBodyOfferPill({Key? key, required this.offerString})
      : super(key: key);

  final String offerString;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Theme.of(context).buttonTheme.colorScheme!.background),
      child: Text(offerString, style: const TextStyle(color: Colors.white)),
    );
  }
}
