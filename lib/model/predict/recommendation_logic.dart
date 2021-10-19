import 'package:equatable/equatable.dart';

import './logic.dart';
import 'cart_item.dart';

class RecommendationLogic extends Equatable implements Logic {
  static const String SEARCH = "SEARCH";
  static const String CART = "CART";
  static const String RELATED = "RELATED";
  static const String CATEGORY = "CATEGORY";
  static const String ALSO_BOUGHT = "ALSO_BOUGHT";
  static const String POPULAR = "POPULAR";
  static const String PERSONAL = "PERSONAL";
  static const String HOME = "HOME";
  @override
  Map<String, dynamic> data;

  @override
  String name;

  @override
  List<String> variants;

  RecommendationLogic._(
      {this.data = const {}, required this.name, this.variants = const []});

  static RecommendationLogic search({String? searchTerm}) {
    Map<String, String> dataMap = {};
    if (searchTerm != null) {
      dataMap["searchTerm"] = searchTerm;
    }
    return RecommendationLogic._(name: SEARCH, data: dataMap);
  }

  static RecommendationLogic cart({List<CartItem>? cartItems}) {
    Map<String, dynamic> dataMap = {};
    if (cartItems != null && cartItems.isNotEmpty) {
      dataMap["cartItems"] = cartItems;
    }
    return RecommendationLogic._(name: CART, data: dataMap);
  }

  static RecommendationLogic related({String? itemId}) {
    Map<String, String> dataMap = {};
    if (itemId != null) {
      dataMap["itemId"] = itemId;
    }
    return RecommendationLogic._(name: RELATED, data: dataMap);
  }

  static RecommendationLogic category({String? categoryPath}) {
    Map<String, String> dataMap = {};
    if (categoryPath != null) {
      dataMap["categoryPath"] = categoryPath;
    }
    return RecommendationLogic._(name: CATEGORY, data: dataMap);
  }

  static RecommendationLogic alsoBought({String? itemId}) {
    Map<String, String> dataMap = {};
    if (itemId != null) {
      dataMap["itemId"] = itemId;
    }
    return RecommendationLogic._(name: ALSO_BOUGHT, data: dataMap);
  }

  static RecommendationLogic popular({String? categoryPath}) {
    Map<String, String> dataMap = {};
    if (categoryPath != null) {
      dataMap["categoryPath"] = categoryPath;
    }
    return RecommendationLogic._(name: POPULAR, data: dataMap);
  }

  static RecommendationLogic personal({List<String> variants = const []}) {
    return RecommendationLogic._(name: PERSONAL, variants: variants);
  }

  static RecommendationLogic home({List<String> variants = const []}) {
    return RecommendationLogic._(name: HOME, variants: variants);
  }

  @override
  List<Object?> get props {
    return [data, name, variants];
  }
}
