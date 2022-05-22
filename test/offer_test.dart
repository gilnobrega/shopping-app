import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/Core/Offers/offer_multibuy_fixed.dart';
import 'package:shopping_app/Core/Offers/offer_multibuy_n_for_n.dart';
import 'package:shopping_app/Core/Offers/offer_none.dart';
import 'package:shopping_app/Core/Offers/offer_single.dart';
import 'package:shopping_app/Core/offer.dart';

void main() {
  test('Offer without discount', () {
    Offer offer = OfferNone(offerId: 1, originalUnitPrice: 100);

    expect(offer.calculateDiscount(itemCount: 1), 0);
    expect(offer.calculateDiscount(), 0);
    expect(offer.calculateOriginalPrice(itemCount: 1), 100);
    expect(offer.calculateFinalPrice(itemCount: 1), 100);
  });
  test('Offer with single discount', () {
    Offer offer =
        OfferSingle(offerId: 1, discountedAmount: 50, originalUnitPrice: 110);

    //tests one unit
    expect(offer.calculateOriginalPrice(itemCount: 1), 110);
    expect(offer.calculateDiscount(itemCount: 1), 50);
    expect(offer.calculateFinalPrice(itemCount: 1), 60);

    //tests two units
    expect(offer.calculateOriginalPrice(itemCount: 2), 220);
    expect(offer.calculateDiscount(itemCount: 2), 100);
    expect(offer.calculateFinalPrice(itemCount: 2), 120);

    //Tests no units
    expect(offer.calculateOriginalPrice(), 0);
    expect(offer.calculateDiscount(), 0);
    expect(offer.calculateFinalPrice(), 0);
  });

  //Each face mask is 1£
  //Three Face Masks for £2.50
  test('Offer with multibuy fixed discount', () {
    Offer offer = OfferMultibuyFixed(
        offerId: 1, offerUnits: 3, offerAmount: 250, originalUnitPrice: 100);

    //tests one unit
    expect(offer.calculateOriginalPrice(itemCount: 1), 100);
    expect(offer.calculateDiscount(itemCount: 1), 0);
    expect(offer.calculateFinalPrice(itemCount: 1), 100);

    //tests two units
    expect(offer.calculateOriginalPrice(itemCount: 2), 200);
    expect(offer.calculateDiscount(itemCount: 2), 0);
    expect(offer.calculateFinalPrice(itemCount: 2), 200);

    //tests three units
    expect(offer.calculateOriginalPrice(itemCount: 3), 300);
    expect(offer.calculateDiscount(itemCount: 3), 50);
    expect(offer.calculateFinalPrice(itemCount: 3), 250);

    //Tests no units
    expect(offer.calculateOriginalPrice(), 0);
    expect(offer.calculateDiscount(), 0);
    expect(offer.calculateFinalPrice(), 0);
  });

  //Each toilet paper roll is 65p
  //4 toiler paper rolls for the price of 3
  test('Offer with multibuy n for n discount', () {
    Offer offer = OfferMultibuyNForN(
        offerId: 1, offerUnits: 4, forUnits: 3, originalUnitPrice: 65);

    //tests one unit
    expect(offer.calculateOriginalPrice(itemCount: 1), 65);
    expect(offer.calculateDiscount(itemCount: 1), 0);
    expect(offer.calculateFinalPrice(itemCount: 1), 65);

    //tests two units
    expect(offer.calculateOriginalPrice(itemCount: 2), 130);
    expect(offer.calculateDiscount(itemCount: 2), 0);
    expect(offer.calculateFinalPrice(itemCount: 2), 130);

    //tests three units
    expect(offer.calculateOriginalPrice(itemCount: 3), 195);
    expect(offer.calculateDiscount(itemCount: 3), 0);
    expect(offer.calculateFinalPrice(itemCount: 3), 195);

    //tests four units
    expect(offer.calculateOriginalPrice(itemCount: 4), 260);
    expect(offer.calculateDiscount(itemCount: 4), 65);
    expect(offer.calculateFinalPrice(itemCount: 4), 195);

    //Tests no units
    expect(offer.calculateOriginalPrice(), 0);
    expect(offer.calculateDiscount(), 0);
    expect(offer.calculateFinalPrice(), 0);
  });
}
