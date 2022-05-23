import 'package:flutter/material.dart';
import 'package:shopping_app/Models/cart_model.dart';

class CheckoutPage extends Page {
  final CartModel cart;

  CheckoutPage({
    required this.cart,
  }) : super(key: ValueKey(cart));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) {
          return CheckoutPageScreen(cart: cart);
        });
  }
}

class CheckoutPageScreen extends StatelessWidget {
  const CheckoutPageScreen({Key? key, required this.cart}) : super(key: key);

  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Checkout")),
        body: const Text("Checkout"));
  }
}
