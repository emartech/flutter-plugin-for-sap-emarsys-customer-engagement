import 'package:emarsys_sdk/model/predict/cart_item.dart';
import 'package:equatable/equatable.dart';

class PredictCartItem extends CartItem with Equatable {
  PredictCartItem(
      {required String itemId, required double price, required double quantity})
      : super(itemId, price, quantity);

  @override
  List<Object?> get props {
    return [itemId, price, quantity];
  }
}
