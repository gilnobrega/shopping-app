import 'package:flutter/material.dart';
import 'package:shopping_app/Models/cart_model.dart';
import 'package:shopping_app/Models/item_model.dart';
import 'package:shopping_app/Widgets/item_list.dart';
import 'package:shopping_app/Widgets/responsive_layout_builder.dart';
import 'package:shopping_app/Widgets/shopping_cart_bottom_sheet.dart';

class CheckoutPage extends Page {
  final CartModel cart;

  CheckoutPage({required this.cart, required this.viewDetails})
      : super(key: ValueKey(cart));

  final Function(ItemModel) viewDetails;

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) {
          return CheckoutPageScreen(
            cart: cart,
            viewDetails: viewDetails,
          );
        });
  }
}

class CheckoutPageScreen extends StatefulWidget {
  const CheckoutPageScreen(
      {Key? key, required this.cart, required this.viewDetails})
      : super(key: key);

  final CartModel cart;
  final Function(ItemModel) viewDetails;

  @override
  State<StatefulWidget> createState() => CheckoutPageScreenState();
}

class CheckoutPageScreenState extends State<CheckoutPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Checkout")),
        body: ResponsiveLayoutBuilder(
            child: ItemList(
          viewDetails: widget.viewDetails,
          cart: widget.cart,
          availableItems: widget.cart.itemsInCart,
          setState: () => setState(() {}),
        )),
        bottomSheet: ShoppingCartBottomBar(
          totalPrice: widget.cart.getTotalPrice(),
          currency: widget.cart.currency,
        ),
        floatingActionButton: Hero(
          tag: "ShoppingCartFloatingButtonHeroTag",
          child: FloatingActionButton(
            tooltip: 'Pay now',
            onPressed: () => executePayment(context),
            heroTag: null,
            child: const Icon(Icons.payment),
          ),
        ));
  }

  void executePayment(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Feature not implemented"),
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: Theme.of(context).primaryColorLight,
        onPressed: () {},
      ),
    ));
  }
}
