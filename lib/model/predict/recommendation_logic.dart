import 'package:equatable/equatable.dart';

import './logic.dart';
import 'cart_item.dart';

class RecommendationLogic extends Logic with EquatableMixin {
  static const String _SEARCH = "SEARCH";
  static const String _CART = "CART";
  static const String _RELATED = "RELATED";
  static const String _CATEGORY = "CATEGORY";
  static const String _ALSO_BOUGHT = "ALSO_BOUGHT";
  static const String _POPULAR = "POPULAR";
  static const String _PERSONAL = "PERSONAL";
  static const String _HOME = "HOME";

  RecommendationLogic._(
      {Map<String, dynamic> data = const {},
      required String name,
      List<String> variants = const []})
      : super(name, data, variants);

  static RecommendationLogic search({String? searchTerm}) {
    Map<String, String> dataMap = {};
    if (searchTerm != null) {
      dataMap["searchTerm"] = searchTerm;
    }
    return RecommendationLogic._(name: _SEARCH, data: dataMap);
  }

  static RecommendationLogic cart({List<CartItem>? cartItems}) {
    Map<String, dynamic> dataMap = {};
    if (cartItems != null && cartItems.isNotEmpty) {
      dataMap["cartItems"] = cartItems;
    }
    return RecommendationLogic._(name: _CART, data: dataMap);
  }

  static RecommendationLogic related({String? itemId}) {
    Map<String, String> dataMap = {};
    if (itemId != null) {
      dataMap["itemId"] = itemId;
    }
    return RecommendationLogic._(name: _RELATED, data: dataMap);
  }

  static RecommendationLogic category({String? categoryPath}) {
    Map<String, String> dataMap = {};
    if (categoryPath != null) {
      dataMap["categoryPath"] = categoryPath;
    }
    return RecommendationLogic._(name: _CATEGORY, data: dataMap);
  }

  static RecommendationLogic alsoBought({String? itemId}) {
    Map<String, String> dataMap = {};
    if (itemId != null) {
      dataMap["itemId"] = itemId;
    }
    return RecommendationLogic._(name: _ALSO_BOUGHT, data: dataMap);
  }

  static RecommendationLogic popular({String? categoryPath}) {
    Map<String, String> dataMap = {};
    if (categoryPath != null) {
      dataMap["categoryPath"] = categoryPath;
    }
    return RecommendationLogic._(name: _POPULAR, data: dataMap);
  }

  static RecommendationLogic personal({List<String> variants = const []}) {
    return RecommendationLogic._(name: _PERSONAL, variants: variants);
  }

  static RecommendationLogic home({List<String> variants = const []}) {
    return RecommendationLogic._(name: _HOME, variants: variants);
  }

  @override
  List<Object?> get props {
    return [data, name, variants];
  }
}
