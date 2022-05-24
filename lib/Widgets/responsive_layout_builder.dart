import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Sets a maximum width of 1000px in case of landscape mode
class ResponsiveLayoutBuilder extends StatelessWidget {
  const ResponsiveLayoutBuilder({Key? key, required this.child})
      : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (context, orientation) => Center(
            child: Container(
                padding: (orientation == Orientation.landscape)
                    ? EdgeInsets.only(top: 16)
                    : null,
                constraints: (orientation == Orientation.landscape)
                    ? const BoxConstraints(maxWidth: 1000)
                    : null,
                child: Card(
                    elevation:
                        (orientation == Orientation.landscape) ? 8 : null,
                    child: child))));
  }
}
