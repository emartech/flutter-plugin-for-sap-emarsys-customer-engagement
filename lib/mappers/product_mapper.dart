import 'package:emarsys_sdk/model/predict/product.dart';

import 'mapper.dart';

class ProductMapper extends Mapper<List<Product>, List<Map<String, dynamic>>> {
  @override
  List<Product> map(List<dynamic> input) {
    return input
        .where((element) => element != null && (element as Map).isNotEmpty)
        .map((productMap) => Product(
            productId: productMap["productId"],
            title: productMap["title"],
            linkUrl: productMap["linkUrl"],
            feature: productMap["feature"],
            cohort: productMap["cohort"],
            customFields: productMap["customFields"],
            imageUrlString: productMap["imageUrlString"],
            imageUrl: productMap["imageUrl"],
            zoomImageUrlString: productMap["zoomImageUrlString"],
            zoomImageUrl: productMap["zoomImageUrl"],
            categoryPath: productMap["categoryPath"],
            available: productMap["available"],
            productDescription: productMap["productDescription"],
            price: productMap["price"],
            msrp: productMap["msrp"],
            album: productMap["album"],
            actor: productMap["actor"],
            artist: productMap["artist"],
            author: productMap["author"],
            brand: productMap["brand"],
            year: productMap["year"]))
        .toList();
  }
}
