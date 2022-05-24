import 'package:flutter/material.dart';
import 'package:shopping_app/Models/cart_model.dart';
import 'package:shopping_app/Models/item_model.dart';
import 'package:shopping_app/Widgets/ItemDetails/item_details.landscape.dart';
import 'package:shopping_app/Widgets/ItemDetails/item_details_portrait.dart';
import 'package:shopping_app/Widgets/ShoppingCartFloatingButton/shopping_cart_floating_button.dart';

class ItemDetailsPage extends Page {
  final ItemModel item;
  final CartModel cart;
  final VoidCallback onShoppingCartFloatingButtonPressed;

  ItemDetailsPage(
      {required this.item,
      required this.cart,
      required this.onShoppingCartFloatingButtonPressed})
      : super(key: ValueKey(item));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) {
          return ItemDetailsPageScreen(
            item: item,
            cart: cart,
            onShoppingCartFloatingButtonPressed:
                onShoppingCartFloatingButtonPressed,
          );
        });
  }
}

class ItemDetailsPageScreen extends StatelessWidget {
  const ItemDetailsPageScreen(
      {Key? key,
      required this.item,
      required this.cart,
      required this.onShoppingCartFloatingButtonPressed})
      : super(key: key);

  final ItemModel item;
  final CartModel cart;
  final VoidCallback onShoppingCartFloatingButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: ShoppingCartFloatingButton(
          key: const ValueKey<String>("CartFloatingButton"),
          currency: cart.currency,
          totalPrice: cart.getTotalPrice(),
          onShoppingCartFloatingButtonPressed:
              onShoppingCartFloatingButtonPressed,
          cartIsEmpty: cart.isEmpty,
        ),
        appBar: AppBar(title: Text(item.title)),
        body: OrientationBuilder(
          builder: (context, orientation) =>
              orientation == Orientation.landscape
                  ? ItemDetailsLandscape(item: item)
                  : ItemDetailsPortrait(item: item),
        ));
  }
}
