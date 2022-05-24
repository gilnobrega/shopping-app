import 'package:flutter/material.dart';
import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Models/cart_model.dart';
import 'package:shopping_app/Models/item_model.dart';
import 'package:shopping_app/Widgets/ItemTile/item_tile.dart';

class ItemList extends StatelessWidget {
  const ItemList(
      {Key? key,
      required this.viewDetails,
      required this.cart,
      required this.availableItems,
      required this.setState})
      : super(key: key);
  final VoidCallback setState;
  final Function(ItemModel) viewDetails;
  final CartModel cart;
  final List<ItemModel> availableItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: availableItems.length,
      itemBuilder: (context, index) {
        ItemModel item = availableItems[index];
        List<Offer> offers =
            cart.getOffersForItem(itemId: item.itemId).toList();

        return ItemTile(
            item: item,
            currency: cart.currency,
            pricePerUnit:
                cart.getPriceForItem(itemId: item.itemId, itemCount: 1),
            totalPrice: cart.getPriceForItem(itemId: item.itemId),
            count: cart.items[item.itemId] ?? 0,
            offers: offers,
            addItem: () {
              cart.addItem(item.itemId);
              setState();
            },
            removeItem: () {
              cart.removeItem(item.itemId);
              setState();
            },
            viewDetails: () {
              viewDetails(item);
            });
      },
    );
  }
}
