import 'package:flutter/material.dart';

class CounterTransition {
  static Widget transitionBuilder(
      Widget child, Animation<double> animation, int newValue, int oldValue) {
    if (newValue == oldValue) {
      return ScaleTransition(scale: animation, child: child);
    }
    //Slides up if price increases
    //Otherwise slides down
    return _slideAnimation(child, animation, newValue > oldValue);
  }

  static Widget _slideAnimation(
      Widget child, Animation<double> animation, bool up) {
    return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
            scale: (Tween<double>(begin: 0.5, end: 1.0)).animate(animation),
            child: SlideTransition(
                position: Tween<Offset>(
                        begin: Offset(0, up ? 1 : -1), end: const Offset(0, 0))
                    .animate(animation),
                child: child)));
  }
}
