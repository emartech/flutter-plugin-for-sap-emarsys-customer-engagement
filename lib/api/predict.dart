import 'package:emarsys_sdk/mappers/cart_item_list_mapper.dart';
import 'package:emarsys_sdk/mappers/logic_mapper.dart';
import 'package:emarsys_sdk/mappers/product_mapper.dart';
import 'package:emarsys_sdk/mappers/product_to_map_mapper.dart';
import 'package:emarsys_sdk/mappers/recommendation_filter_list_mapper.dart';
import 'package:emarsys_sdk/model/predict/cart_item.dart';
import 'package:emarsys_sdk/model/predict/logic.dart';
import 'package:emarsys_sdk/model/predict/product.dart';
import 'package:emarsys_sdk/model/predict/recommendation_filter.dart';
import 'package:flutter/services.dart';

class Predict {
  final MethodChannel _channel;
  final ProductMapper _productMapper;
  final LogicMapper _logicMapper;
  final CartItemListMapper _cartItemListMapper;
  final RecommendationFilterListMapper _recommendationFilterListMapper;
  final ProductToMapMapper _productToMapMapper;

  Predict(this._channel, this._productMapper, this._cartItemListMapper,
      this._recommendationFilterListMapper, this._productToMapMapper)
      : _logicMapper = LogicMapper(_cartItemListMapper);

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
      String eventName, Map<String, String>? attributes) async {
    return _channel.invokeMethod(
        'predict.trackTag', {'eventName': eventName, 'attributes': attributes});
  }

  Future<void> trackCart(List<CartItem> items) async {
    return _channel.invokeMethod(
        'predict.trackCart', {'items': _cartItemListMapper.map(items)});
  }

  Future<void> trackPurchase(String orderId, List<CartItem> items) async {
    if (items.isNotEmpty) {
      return _channel.invokeMethod('predict.trackPurchase',
          {"orderId": orderId, 'items': _cartItemListMapper.map(items)});
    } else {
      throw PlatformException(
          code: '42', message: 'Items list should not be empty!');
    }
  }

  Future<void> trackRecommendationClick(Product product) async {
    return _channel.invokeMethod('predict.trackRecommendationClick',
        {"product": _productToMapMapper.map(product)});
  }

  Future<List<Product>> recommendProducts(
      {required Logic logic,
      List<RecommendationFilter>? filters,
      int? limit,
      String? availabilityZone}) async {
    Map<String, dynamic> attributes = {"logic": _logicMapper.map(logic)};
    if (filters != null) {
      attributes["recommendationFilter"] =
          _recommendationFilterListMapper.map(filters);
    }
    if (limit != null) {
      attributes["limit"] = limit;
    }
    if (availabilityZone != null) {
      attributes["availabilityZone"] = availabilityZone;
    }
    List<dynamic>? products =
        await _channel.invokeMethod('predict.recommendProducts', attributes);
    if (products == null) {
      throw TypeError();
    }
    return _productMapper.map(products);
  }
}
