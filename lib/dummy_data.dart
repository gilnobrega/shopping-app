import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Core/Offers/offer_multibuy_fixed.dart';
import 'package:shopping_app/Core/Offers/offer_multibuy_n_for_n.dart';
import 'package:shopping_app/Core/Offers/offer_none.dart';
import 'package:shopping_app/Core/Offers/offer_single.dart';
import 'package:shopping_app/Core/currency.dart';
import 'package:shopping_app/Models/cart_model.dart';
import 'package:shopping_app/Models/item_model.dart';
import 'package:shopping_app/constants.dart';

CartModel generateDummyCart() {
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
          "https://static8.depositphotos.com/1177973/812/i/600/depositphotos_8121720-stock-photo-delicious-potato-chips-in-bowl.jpg");

  ItemModel item4 = ItemModel(
      itemId: 4,
      title: "Butter",
      description: Constants.loremIpsum,
      pictureUrl:
          "https://media.istockphoto.com/photos/piece-of-melting-butter-isolated-on-white-background-butter-cube-picture-id1241231043?k=20&m=1241231043&s=612x612&w=0&h=a5CzDU7Y-HfEpppFTuUooejIB72mMt9vxary94KyRrs=");

  ItemModel item5 = ItemModel(
      itemId: 5,
      title: "Egg",
      description: Constants.loremIpsum,
      pictureUrl:
          "https://upload.wikimedia.org/wikipedia/en/thumb/5/58/Instagram_egg.jpg/220px-Instagram_egg.jpg");

  ItemModel item6 = ItemModel(
      itemId: 6,
      title: "Milk",
      description: Constants.loremIpsum,
      pictureUrl:
          "https://media.istockphoto.com/photos/skim-milk-picture-id459000487?s=2048x2048");

  Offer offer1 = OfferMultibuyFixed(
      offerUnits: 2, offerAmount: 400, itemId: 1, originalUnitPrice: 250);
  Offer offer2 = OfferMultibuyNForN(
      offerUnits: 6, forUnits: 5, itemId: 2, originalUnitPrice: 65);
  Offer offer3 = OfferNone(itemId: 3, originalUnitPrice: 195);
  Offer offer4 =
      OfferSingle(itemId: 4, discountedAmount: 15, originalUnitPrice: 195);

  Offer offer5 = OfferMultibuyNForN(
      itemId: 4, offerUnits: 3, forUnits: 2, originalUnitPrice: 195);

  Offer offer6 = OfferMultibuyFixed(
      itemId: 5, originalUnitPrice: 33, offerUnits: 12, offerAmount: 200);
  Offer offer7 = OfferNone(itemId: 6, originalUnitPrice: 67);

  CartModel cart = CartModel(
      currency: currency,
      availableOffers: [offer1, offer2, offer3, offer4, offer5, offer6, offer7],
      availableItems: [item1, item2, item3, item4, item5, item6]);

  return cart;
}
