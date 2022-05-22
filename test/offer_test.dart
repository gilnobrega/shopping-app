import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/Core/Offers/offer_multibuy_fixed.dart';
import 'package:shopping_app/Core/Offers/offer_multibuy_n_for_n.dart';
import 'package:shopping_app/Core/Offers/offer_none.dart';
import 'package:shopping_app/Core/Offers/offer_single.dart';
import 'package:shopping_app/Core/Offers/offer.dart';
import 'package:shopping_app/Core/price.dart';

void main() {
  test('Offer without discount', () {
    Offer offer = OfferNone(offerId: 1, originalUnitPrice: 100);

    Price price1Item = offer.getPrice(itemCount: 1);
    Price priceNoItems = offer.getPrice(itemCount: 0);

    expect(price1Item.discountedAmount, 0);
    expect(price1Item.originalAmount, 100);
    expect(price1Item.finalAmount, 100);

    expect(priceNoItems.discountedAmount, 0);
    expect(priceNoItems.finalAmount, 0);
    expect(priceNoItems.originalAmount, 0);
  });
  test('Offer with single discount', () {
    Offer offer =
        OfferSingle(offerId: 1, discountedAmount: 50, originalUnitPrice: 110);

    Price priceNoItems = offer.getPrice(itemCount: 0);
    Price price1Item = offer.getPrice(itemCount: 1);
    Price price2Items = offer.getPrice(itemCount: 2);

    //Tests no units
    expect(priceNoItems.originalAmount, 0);
    expect(priceNoItems.finalAmount, 0);
    expect(priceNoItems.discountedAmount, 0);

    //tests one unit
    expect(price1Item.originalAmount, 110);
    expect(price1Item.discountedAmount, 50);
    expect(price1Item.finalAmount, 60);

    //tests two units
    expect(price2Items.originalAmount, 220);
    expect(price2Items.discountedAmount, 100);
    expect(price2Items.finalAmount, 120);
  });

  //Each face mask is 1£
  //Three Face Masks for £2.50
  test('Offer with multibuy fixed discount', () {
    Offer offer = OfferMultibuyFixed(
        offerId: 1, offerUnits: 3, offerAmount: 250, originalUnitPrice: 100);

    Price priceNoItems = offer.getPrice(itemCount: 0);
    Price price1Item = offer.getPrice(itemCount: 1);
    Price price2Items = offer.getPrice(itemCount: 2);
    Price price3Items = offer.getPrice(itemCount: 3);
    Price price4Items = offer.getPrice(itemCount: 4);

    //Tests no units
    expect(priceNoItems.originalAmount, 0);
    expect(priceNoItems.finalAmount, 0);
    expect(priceNoItems.discountedAmount, 0);

    //tests one unit
    expect(price1Item.originalAmount, 100);
    expect(price1Item.discountedAmount, 0);
    expect(price1Item.finalAmount, 100);

    //tests two units
    expect(price2Items.originalAmount, 200);
    expect(price2Items.discountedAmount, 0);
    expect(price2Items.finalAmount, 200);

    //tests three units
    expect(price3Items.originalAmount, 300);
    expect(price3Items.discountedAmount, 50);
    expect(price3Items.finalAmount, 250);

    //tests four units
    expect(price4Items.originalAmount, 400);
    expect(price4Items.discountedAmount, 50);
    expect(price4Items.finalAmount, 350);
  });

  //Each toilet paper roll is 65p
  //4 toiler paper rolls for the price of 3
  test('Offer with multibuy n for n discount', () {
    Offer offer = OfferMultibuyNForN(
        offerId: 1, offerUnits: 4, forUnits: 3, originalUnitPrice: 65);

    Price priceNoItems = offer.getPrice(itemCount: 0);
    Price price1Item = offer.getPrice(itemCount: 1);
    Price price2Items = offer.getPrice(itemCount: 2);
    Price price3Items = offer.getPrice(itemCount: 3);
    Price price4Items = offer.getPrice(itemCount: 4);
    Price price5Items = offer.getPrice(itemCount: 5);

    //Tests no units
    expect(priceNoItems.originalAmount, 0);
    expect(priceNoItems.finalAmount, 0);
    expect(priceNoItems.discountedAmount, 0);

    //tests one unit
    expect(price1Item.originalAmount, 65);
    expect(price1Item.discountedAmount, 0);
    expect(price1Item.finalAmount, 65);

    //tests two units
    expect(price2Items.originalAmount, 130);
    expect(price2Items.discountedAmount, 0);
    expect(price2Items.finalAmount, 130);

    //tests three units
    expect(price3Items.originalAmount, 195);
    expect(price3Items.discountedAmount, 0);
    expect(price3Items.finalAmount, 195);

    //tests four units
    expect(price4Items.originalAmount, 260);
    expect(price4Items.discountedAmount, 65);
    expect(price4Items.finalAmount, 195);

    //tests five units
    expect(price5Items.originalAmount, 325);
    expect(price5Items.discountedAmount, 65);
    expect(price5Items.finalAmount, 260);
  });

  test('Expect Exceptions on negative offers', () {
    //Negative original unit price
    expect(() => OfferNone(offerId: 1, originalUnitPrice: -100),
        throwsA(isA<Exception>()));

    //negative discounted amount
    expect(
        () => OfferSingle(
            offerId: 1, discountedAmount: -50, originalUnitPrice: 110),
        throwsA(isA<Exception>()));

    //negative amount in multibuy
    expect(
        () => OfferMultibuyFixed(
            offerId: 1,
            offerUnits: 3,
            offerAmount: -250,
            originalUnitPrice: 100),
        throwsA(isA<Exception>()));
  });
}
