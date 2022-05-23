import 'package:flutter/material.dart';
import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Core/Offers/offer_multibuy_fixed.dart';
import 'package:shopping_app/Core/Offers/offer_multibuy_n_for_n.dart';
import 'package:shopping_app/Core/Offers/offer_none.dart';
import 'package:shopping_app/Core/Offers/offer_single.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Models/cart_model.dart';
import 'package:shopping_app/Models/item_model.dart';
import 'package:shopping_app/Widgets/item_tile.dart';
import 'package:shopping_app/Widgets/shopping_cart_floating_button.dart';

void main() {
  Currency currency = Currency(name: "GBP", symbolMajor: "£", symbolMinor: "p");

  ItemModel item1 = ItemModel(
      itemId: 1,
      title: "Face Mask",
      pictureUrl:
          "https://m.media-amazon.com/images/I/61+ilDgVVwS._UL1500_.jpg");
  ItemModel item2 = ItemModel(
      itemId: 2,
      title: "Toilet Roll",
      pictureUrl:
          "https://image.made-in-china.com/2f0j00QmUETpwCOdua/4-Ply-180g-Roll-Individual-Packing-Toilet-Tissue-Paper.jpg");

  ItemModel item3 = ItemModel(
      itemId: 3,
      title: "Crisps",
      pictureUrl:
          "https://assets.sainsburys-groceries.co.uk/gol/6447861/1/640x640.jpg");

  ItemModel item4 = ItemModel(
      itemId: 4,
      title: "Butter",
      pictureUrl:
          "https://assets.sainsburys-groceries.co.uk/gol/2242583/1/640x640.jpg");

  Offer offer1 = OfferMultibuyFixed(
      offerUnits: 2, offerAmount: 400, itemId: 1, originalUnitPrice: 250);
  Offer offer2 = OfferMultibuyNForN(
      offerUnits: 4, forUnits: 3, itemId: 2, originalUnitPrice: 65);
  Offer offer3 = OfferNone(itemId: 3, originalUnitPrice: 195);
  Offer offer4 =
      OfferSingle(itemId: 4, discountedAmount: 15, originalUnitPrice: 195);

  CartModel cart = CartModel(
      currency: currency,
      availableOffers: [offer1, offer2, offer3, offer4],
      availableItems: [item1, item2, item3, item4]);

  runApp(MyApp(
    cart: cart,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.cart}) : super(key: key);

  final CartModel cart;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: MyHomePage(
        title: 'Shopping App',
        cart: cart,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.cart})
      : super(key: key);
  final String title;
  final CartModel cart;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: widget.cart.availableItems.length,
        itemBuilder: (context, index) {
          ItemModel item = widget.cart.availableItems[index];
          List<Offer> offers =
              widget.cart.getOffersForItem(itemId: item.itemId).toList();

          return ItemTile(
            item: item,
            currency: widget.cart.currency,
            price:
                widget.cart.getPriceForItem(itemId: item.itemId, itemCount: 1),
            count: widget.cart.items[item.itemId] ?? 0,
            offer: offers.length > 0 ? offers.first : null,
            addItem: () {
              setState(() {
                widget.cart.addItem(item.itemId);
              });
            },
            removeItem: () {
              setState(() {
                widget.cart.removeItem(item.itemId);
              });
            },
          );
        },
      ),
      floatingActionButton: ShoppingCartFloatingButton(
          currency: widget.cart.currency,
          totalPrice: widget.cart.getTotalPrice()),
    );
  }
}
