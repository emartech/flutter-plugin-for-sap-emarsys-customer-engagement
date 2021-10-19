import 'package:emarsys_sdk/model/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Predict {
  final MethodChannel _channel;
  Predict(this._channel);

  Future<void> trackItemView(String itemId) async {
    return _channel.invokeMethod('predict.trackItemView', {'itemId': itemId});
  }

  Future<void> trackSearchTerm(String searchTerm) async {
    return _channel
        .invokeMethod('predict.trackSearchTerm', {'searchTerm': searchTerm});
  }

  Future<void> trackCategoryView(String categoryPath) async {
    return _channel.invokeMethod(
        'predict.trackCategoryView', {'categoryPath': categoryPath});
  }

  Future<void> trackTag(
      String eventName, Map<String, String> attributes) async {
    return _channel.invokeMethod(
        'predict.trackTag', {'eventName': eventName, 'attributes': attributes});
  }

  Future<void> trackCart(List<CartItem> items) async {
    return _channel.invokeMethod('predict.trackCart', {
      'items':
          items.map((CartItem cartItem) => _cartItemToMap(cartItem)).toList()
    });
  }

  Future<void> trackPurchase(String orderId, List<CartItem> items) async {
    return _channel.invokeMethod('predict.trackPurchase', {
      "orderId": orderId,
      'items':
          items.map((CartItem cartItem) => _cartItemToMap(cartItem)).toList()
    });
  }

  Map<String, dynamic> _cartItemToMap(CartItem cartItem) {
    return {
      "itemId": cartItem.itemId,
      "price": cartItem.price,
      "quantity": cartItem.quantity,
    };
  }
}
