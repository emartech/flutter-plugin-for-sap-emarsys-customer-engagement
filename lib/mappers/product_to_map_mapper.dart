import 'package:emarsys_sdk/mappers/mapper.dart';
import 'package:emarsys_sdk/model/predict/product.dart';

class ProductToMapMapper extends Mapper<Product, Map<String, dynamic>> {
  @override
  Map<String, dynamic> map(Product input) {
    Map<String, dynamic> productMap = {
      "productId": input.productId,
      "title": input.title,
      "linkUrl": input.linkUrl,
      "feature": input.feature,
      "cohort": input.cohort,
      "customFields": input.customFields,
      "imageUrlString": input.imageUrlString,
      "zoomImageUrlString": input.zoomImageUrlString,
      "categoryPath": input.categoryPath,
      "available": input.available,
      "productDescription": input.productDescription,
      "price": input.price,
      "msrp": input.msrp,
      "album": input.album,
      "actor": input.actor,
      "artist": input.artist,
      "author": input.author,
      "brand": input.brand,
      "year": input.year,
    };
    return productMap;
  }
}
