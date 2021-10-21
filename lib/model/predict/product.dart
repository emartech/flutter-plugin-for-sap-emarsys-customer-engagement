import 'package:equatable/equatable.dart';

class Product extends Equatable {
  late String productId;
  late String title;
  late String linkUrl;
  late String feature;
  late String cohort;
  late Map customFields;
  String? imageUrlString;
  String? imageUrl;
  String? zoomImageUrlString;
  String? zoomImageUrl;
  String? categoryPath;
  bool? available;
  String? productDescription;
  double? price;
  double? msrp;
  String? album;
  String? actor;
  String? artist;
  String? author;
  String? brand;
  int? year;

  Product({
      required this.productId,
      required this.title,
      required this.linkUrl,
      required this.feature,
      required this.cohort,
      required this.customFields,
      this.imageUrlString,
      this.imageUrl,
      this.zoomImageUrlString,
      this.zoomImageUrl,
      this.categoryPath,
      this.available,
      this.productDescription,
      this.price,
      this.msrp,
      this.album,
      this.actor,
      this.artist,
      this.author,
      this.brand,
      this.year});

  @override
  List<Object?> get props {
    return [
      productId,
      title,
      linkUrl,
      feature,
      cohort,
      customFields,
      imageUrlString,
      imageUrl,
      zoomImageUrlString,
      zoomImageUrl,
      categoryPath,
      available,
      productDescription,
      price,
      msrp,
      album,
      actor,
      artist,
      author,
      brand,
      year
    ];
  }
}
