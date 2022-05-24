import 'package:flutter/material.dart';
import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Models/cart_model.dart';
import 'package:shopping_app/Models/item_model.dart';
import 'package:shopping_app/Widgets/item_tile.dart';
import 'package:shopping_app/Widgets/shopping_cart_floating_button.dart';

class AvailableItemsPage extends StatefulWidget {
  const AvailableItemsPage(
      {Key? key,
      required this.title,
      required this.cart,
      required this.viewDetails,
      required this.onShoppingCartFloatingButtonPressed})
      : super(key: key);
  final String title;
  final CartModel cart;
  final Function(ItemModel) viewDetails;
  final VoidCallback onShoppingCartFloatingButtonPressed;

  @override
  State<AvailableItemsPage> createState() => _AvailableItemsPageState();
}

class _AvailableItemsPageState extends State<AvailableItemsPage> {
  bool _showSearchBar = false;

  late List<ItemModel> availableItems;

  void _toggleSearchBar() {
    setState(() {
      _showSearchBar = !_showSearchBar;
    });

    if (!_showSearchBar) searchForItems();
  }

  @override
  void initState() {
    //gets all items
    searchForItems();
    super.initState();
  }

  void searchForItems([String searchFor = ""]) {
    availableItems = searchFor.isEmpty
        ? widget.cart.availableItems
        : widget.cart.availableItems
            .where((item) => item.title
                .toLowerCase()
                .contains(searchFor.toLowerCase().trim()))
            .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (_showSearchBar)
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: TextFormField(
                  autofocus: true,
                  onChanged: searchForItems,
                  style: Theme.of(context).primaryTextTheme.titleMedium,
                  decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      labelText: 'Search for item...',
                      labelStyle:
                          Theme.of(context).primaryTextTheme.titleMedium),
                ))
            : Text(widget.title),
        actions: [
          //Toggles visibility of search bar
          IconButton(
              onPressed: _toggleSearchBar,
              icon: Icon(
                (_showSearchBar) ? Icons.close : Icons.search,
                size: 24.0,
              ))
        ],
      ),
      body: ListView.builder(
        itemCount: availableItems.length,
        itemBuilder: (context, index) {
          ItemModel item = availableItems[index];
          List<Offer> offers =
              widget.cart.getOffersForItem(itemId: item.itemId).toList();

          return ItemTile(
              item: item,
              currency: widget.cart.currency,
              pricePerUnit: widget.cart
                  .getPriceForItem(itemId: item.itemId, itemCount: 1),
              totalPrice: widget.cart.getPriceForItem(itemId: item.itemId),
              count: widget.cart.items[item.itemId] ?? 0,
              offers: offers,
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
              viewDetails: () {
                widget.viewDetails(item);
              });
        },
      ),
      floatingActionButton: ShoppingCartFloatingButton(
        key: const ValueKey<String>("CartFloatingButton"),
        currency: widget.cart.currency,
        totalPrice: widget.cart.getTotalPrice(),
        onShoppingCartFloatingButtonPressed:
            widget.onShoppingCartFloatingButtonPressed,
        cartIsEmpty: widget.cart.isEmpty,
      ),
    );
  }
}
