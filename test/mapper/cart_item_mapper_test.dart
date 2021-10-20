import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:emarsys_sdk/mappers/cart_item_list_mapper.dart';
import 'package:emarsys_sdk/model/predict/predict_cart_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final CartItemListMapper mapper = CartItemListMapper();

  test('map should not crash when inputList is empty', () async {
    final List<CartItem> emptyList = [];
    final List<Map<String, dynamic>> result = mapper.map(emptyList);

    expect(result.length, 0);
  });

  test('map should return with correct result', () async {
    List<Map<String, dynamic>> expected = [
      {"itemId": "id1", "price": 1, "quantity": 1},
      {"itemId": "id2", "price": 2, "quantity": 2}
    ];
    List<CartItem> cartItems = [
      PredictCartItem(itemId: "id1", price: 1, quantity: 1),
      PredictCartItem(itemId: "id2", price: 2, quantity: 2)
    ];

    List<Map<String, dynamic>> result = mapper.map(cartItems);

    expect(result, expected);
  });
}
