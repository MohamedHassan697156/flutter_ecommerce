import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final List<String> images;
  final String category;
  final double rating;
  final int reviewCount;
  final bool inStock;
  final List<String> sizes;
  final List<String> colors;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    this.images = const [],
    required this.category,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.inStock = true,
    this.sizes = const [],
    this.colors = const [],
  });

  double get discountPercent {
    if (originalPrice == null || originalPrice! <= price) return 0;
    return ((originalPrice! - price) / originalPrice! * 100).roundToDouble();
  }

  bool get hasDiscount => discountPercent > 0;

  Product copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    double? originalPrice,
    String? imageUrl,
    List<String>? images,
    String? category,
    double? rating,
    int? reviewCount,
    bool? inStock,
    List<String>? sizes,
    List<String>? colors,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      imageUrl: imageUrl ?? this.imageUrl,
      images: images ?? this.images,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      inStock: inStock ?? this.inStock,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
    );
  }

  @override
  List<Object?> get props => [id, name, price, category];
}
