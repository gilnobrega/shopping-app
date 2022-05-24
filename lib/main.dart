import 'package:flutter/material.dart';
import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Core/Offers/offer_multibuy_fixed.dart';
import 'package:shopping_app/Core/Offers/offer_multibuy_n_for_n.dart';
import 'package:shopping_app/Core/Offers/offer_none.dart';
import 'package:shopping_app/Core/Offers/offer_single.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Models/cart_model.dart';
import 'package:shopping_app/Models/item_model.dart';
import 'package:shopping_app/Pages/available_items_page.dart';
import 'package:shopping_app/Pages/checkout_page.dart';
import 'package:shopping_app/Pages/item_details_page.dart';
import 'package:shopping_app/constants.dart';

void main() {
  Currency currency = Currency(name: "GBP", symbolMajor: "£", symbolMinor: "p");

  ItemModel item1 = ItemModel(
      itemId: 1,
      title: "Face Mask",
      description: Constants.loremIpsum,
      pictureUrl:
          "https://m.media-amazon.com/images/I/61+ilDgVVwS._UL1500_.jpg");
  ItemModel item2 = ItemModel(
      itemId: 2,
      title: "Toilet Roll",
      description: Constants.loremIpsum,
      pictureUrl:
          "https://image.made-in-china.com/2f0j00QmUETpwCOdua/4-Ply-180g-Roll-Individual-Packing-Toilet-Tissue-Paper.jpg");

  ItemModel item3 = ItemModel(
      itemId: 3,
      title: "Crisps",
      description: Constants.loremIpsum,
      pictureUrl:
          "https://assets.sainsburys-groceries.co.uk/gol/6447861/1/640x640.jpg");

  ItemModel item4 = ItemModel(
      itemId: 4,
      title: "Butter",
      description: Constants.loremIpsum,
      pictureUrl:
          "https://assets.sainsburys-groceries.co.uk/gol/2242583/1/640x640.jpg");

  Offer offer1 = OfferMultibuyFixed(
      offerUnits: 2, offerAmount: 400, itemId: 1, originalUnitPrice: 250);
  Offer offer2 = OfferMultibuyNForN(
      offerUnits: 4, forUnits: 3, itemId: 2, originalUnitPrice: 65);
  Offer offer3 = OfferNone(itemId: 3, originalUnitPrice: 195);
  Offer offer4 =
      OfferSingle(itemId: 4, discountedAmount: 15, originalUnitPrice: 195);

  Offer offer5 = OfferMultibuyNForN(
      itemId: 4, offerUnits: 3, forUnits: 2, originalUnitPrice: 195);

  CartModel cart = CartModel(
      currency: currency,
      availableOffers: [offer1, offer2, offer3, offer4, offer5],
      availableItems: [item1, item2, item3, item4]);

  runApp(ShoppingApp(
    cart: cart,
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
          if (_currentItem != null)
            ItemDetailsPage(
                item: _currentItem!,
                cart: widget.cart,
                onShoppingCartFloatingButtonPressed:
                    onShoppingCartFloatingButtonPressed),
          if (_showCheckoutPage)
            CheckoutPage(cart: widget.cart, viewDetails: viewItemDetails)
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
    });
  }

  void viewItemDetails(ItemModel item) {
    setState(() {
      _currentItem = item;
    });
  }
}
