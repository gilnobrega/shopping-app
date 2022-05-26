import 'package:flutter/material.dart';
import 'package:shopping_app/Models/cart_model.dart';
import 'package:shopping_app/Models/item_model.dart';
import 'package:shopping_app/Pages/available_items_page.dart';
import 'package:shopping_app/Pages/checkout_page.dart';
import 'package:shopping_app/Pages/item_details_page.dart';
import 'package:shopping_app/dummy_data.dart';

void main() {
  runApp(ShoppingApp(
    cart: generateDummyCart(),
  ));
}

class ShoppingApp extends StatefulWidget {
  const ShoppingApp({Key? key, required this.cart}) : super(key: key);
  final CartModel cart;

  @override
  State<StatefulWidget> createState() => _ShoppingAppState();
}

class _ShoppingAppState extends State<ShoppingApp> {
  static const String _appTitle = "Shopping App";
  final heroController = HeroController();

  ItemModel? _currentItem;
  bool _showCheckoutPage = false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _appTitle,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: Navigator(
        observers: [heroController],
        pages: [
          MaterialPage(
              child: AvailableItemsPage(
            title: _appTitle,
            cart: widget.cart,
            viewDetails: viewItemDetails,
            onShoppingCartFloatingButtonPressed:
                onShoppingCartFloatingButtonPressed,
          )),
          if (_showCheckoutPage)
            CheckoutPage(cart: widget.cart, viewDetails: viewItemDetails),
          if (_currentItem != null)
            ItemDetailsPage(
                item: _currentItem!,
                cart: widget.cart,
                onShoppingCartFloatingButtonPressed:
                    onShoppingCartFloatingButtonPressed),
        ],
        //Resets item if page pops (previous page sign)
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;
          setState(() {
            _currentItem = null;
            _showCheckoutPage = false;
          });

          return true;
        },
      ),
    );
  }

  void onShoppingCartFloatingButtonPressed() {
    setState(() {
      _showCheckoutPage = true;
      _currentItem = null;
    });
  }

  void viewItemDetails(ItemModel item) {
    setState(() {
      _currentItem = item;
    });
  }
}
