import 'package:flutter/material.dart';

//Sets a maximum width of 1000px in case of landscape mode
class ResponsiveLayoutBuilder extends StatelessWidget {
  const ResponsiveLayoutBuilder(
      {Key? key, required this.child, this.isCard = true})
      : super(key: key);
  final Widget child;
  final bool isCard;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (context, orientation) => Center(
            child: Container(
                padding: (orientation == Orientation.landscape)
                    ? const EdgeInsets.only(top: 16)
                    : null,
                constraints: (orientation == Orientation.landscape)
                    ? const BoxConstraints(maxWidth: 1000)
                    : null,
                child: (isCard)
                    ? Card(
                        elevation:
                            (orientation == Orientation.landscape) ? 8 : null,
                        child: child)
                    : child)));
  }
}
