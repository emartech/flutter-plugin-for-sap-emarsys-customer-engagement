import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String productId;
  final String title;
  final String linkUrl;
  final String feature;
  final String cohort;
  final Map customFields;
  final String? imageUrlString;
  final Uri? imageUrl;
  final String? zoomImageUrlString;
  final Uri? zoomImageUrl;
  final String? categoryPath;
  final bool? available;
  final String? productDescription;
  final double? price;
  final double? msrp;
  final String? album;
  final String? actor;
  final String? artist;
  final String? author;
  final String? brand;
  final int? year;

  Product(
      {required this.productId,
      required this.title,
      required this.linkUrl,
      required this.feature,
      required this.cohort,
      required this.customFields,
      this.imageUrlString,
      this.zoomImageUrlString,
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
      this.year})
      : imageUrl = imageUrlString != null ? Uri.parse(imageUrlString) : null,
        zoomImageUrl =
            zoomImageUrlString != null ? Uri.parse(zoomImageUrlString) : null;

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
