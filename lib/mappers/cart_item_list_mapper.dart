import 'package:emarsys_sdk/mappers/mapper.dart';
import 'package:emarsys_sdk/model/predict/cart_item.dart';

class CartItemListMapper
    extends Mapper<List<Map<String, dynamic>>, List<CartItem>> {
  @override
  List<Map<String, dynamic>> map(List<CartItem> input) {
    return input.map((cartItem) => mapCartItem(cartItem)).toList();
  }

  Map<String, dynamic> mapCartItem(CartItem input) {
    return {
      "itemId": input.itemId,
      "price": input.price,
      "quantity": input.quantity,
    };
  }
}
