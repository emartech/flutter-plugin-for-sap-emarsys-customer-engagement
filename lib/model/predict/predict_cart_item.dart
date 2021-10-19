import 'package:emarsys_sdk/model/predict/cart_item.dart';
import 'package:equatable/equatable.dart';

class PredictCartItem extends Equatable implements CartItem {
  @override
  String itemId;

  @override
  double price;

  @override
  double quantity;

  PredictCartItem(
      {required this.itemId, required this.price, required this.quantity});

  @override
  List<Object?> get props {
    return [itemId, price, quantity];
  }
}
