import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:emarsys_sdk/mappers/cart_item_list_mapper.dart';
import 'package:emarsys_sdk/mappers/mapper.dart';
import 'package:emarsys_sdk/model/predict/logic.dart';

class LogicMapper extends Mapper<Map<String, dynamic>, Logic> {
  final CartItemListMapper _cartItemListMapper;

  LogicMapper(this._cartItemListMapper);

  @override
  Map<String, dynamic> map(Logic input) {
    var mapFromLogic = Map<String, dynamic>();
    mapFromLogic["name"] = input.name;
    if (mapFromLogic["name"] == RecommendationLogic.CART) {
      mapFromLogic["data"] = {};
      mapFromLogic["data"]["cartItems"] =
          _cartItemListMapper.map(input.data["cartItems"]);
    } else {
      mapFromLogic["data"] = input.data;
    }
    mapFromLogic["variants"] = input.variants;

    return mapFromLogic;
  }
}