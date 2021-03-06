import 'package:flutter/material.dart';
import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Core/price.dart';
import 'package:shopping_app/Enums/offer_type.dart';
import 'package:shopping_app/Models/cart_model.dart';
import 'package:shopping_app/Models/item_model.dart';
import 'package:shopping_app/Widgets/ItemTile/item_tile_buttons.dart';
import 'package:shopping_app/Widgets/ItemTile/item_tile_main.dart';

class ItemTile extends StatelessWidget {
  const ItemTile(
      {Key? key,
      required this.item,
      required this.pricePerUnit,
      required this.totalPrice,
      required this.currency,
      required this.count,
      required this.addItem,
      required this.removeItem,
      required this.viewDetails,
      required this.isCheckoutScreen,
      required this.cart,
      required this.offers,
      required this.setState})
      : super(key: key);

  final ItemModel item;
  final List<Offer> offers;
  final Price pricePerUnit;
  final Price totalPrice;
  final Currency currency;
  final int count;
  final VoidCallback addItem;
  final VoidCallback removeItem;
  final VoidCallback viewDetails;
  final bool isCheckoutScreen;
  final VoidCallback setState;
  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Stack(
        alignment: AlignmentDirectional.center,
        children: [
          ItemTileMainBody(
            setState: setState,
            cart: cart,
            isCheckoutScreen: isCheckoutScreen,
            item: item,
            currency: currency,
            offers: offers
                .where((offer) => offer.offerType != OfferType.none)
                .toList(),
            pricePerUnit: pricePerUnit,
            totalPrice: totalPrice,
            viewDetails: viewDetails,
          ),
          ItemTileButtons(
            addItem: addItem,
            removeItem: removeItem,
            count: count,
          )
        ],
      ),
    ]);
  }
}
