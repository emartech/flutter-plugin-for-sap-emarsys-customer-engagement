import 'package:emarsys_sdk/model/predict/product.dart';

import 'mapper.dart';

class ProductMapper extends Mapper<List<Product>, List<Map<String, dynamic>>> {
  @override
  List<Product> map(List<dynamic> input) {
    return input
        .where((element) => element != null && (element as Map).isNotEmpty)
        .map((productMap) => Product(
            productMap["productId"],
            productMap["title"],
            productMap["linkUrl"],
            productMap["feature"],
            productMap["cohort"],
            productMap["customFields"],
            productMap["imageUrlString"],
            productMap["imageUrl"],
            productMap["zoomImageUrlString"],
            productMap["zoomImageUrl"],
            productMap["categoryPath"],
            productMap["available"],
            productMap["productDescription"],
            productMap["price"],
            productMap["msrp"],
            productMap["album"],
            productMap["actor"],
            productMap["artist"],
            productMap["author"],
            productMap["brand"],
            productMap["year"]))
        .toList();
  }
}
