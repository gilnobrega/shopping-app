import 'package:flutter/material.dart';
import 'package:shopping_app/Models/cart_model.dart';

class ClearCartAction extends StatelessWidget {
  const ClearCartAction({
    Key? key,
    required this.cart,
    required this.setState,
  }) : super(key: key);

  final CartModel cart;
  final VoidCallback setState;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(right: 4.0),
        child: IconButton(
            tooltip: 'Empties cart',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    const Text("Are you sure you want to clear this list?"),
                action: SnackBarAction(
                  label: 'Yes',
                  textColor: Theme.of(context).primaryColorLight,
                  onPressed: () {
                    cart.clearCart();
                    Navigator.pop(context);

                    setState();
                  },
                ),
              ));
            },
            // ignore: prefer_const_constructors
            icon: const Icon(
              Icons.remove_shopping_cart_outlined,
              size: 24.0,
            )));
  }
}
