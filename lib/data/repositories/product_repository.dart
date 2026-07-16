import '../models/product_model.dart';

class ProductRepository {
  static final ProductRepository _instance = ProductRepository._();
  factory ProductRepository() => _instance;
  ProductRepository._();

  final List<String> categories = [
    'All',
    'Electronics',
    'Fashion',
    'Home',
    'Sports',
    'Beauty',
  ];

  List<Product> getAllProducts() => _mockProducts;

  List<Product> getByCategory(String category) {
    if (category == 'All') return _mockProducts;
    return _mockProducts
        .where((p) => p.category == category)
        .toList();
  }

  List<Product> search(String query) {
    final q = query.toLowerCase();
    return _mockProducts
        .where((p) =>
            p.name.toLowerCase().contains(q) ||
            p.category.toLowerCase().contains(q))
        .toList();
  }

  List<Product> getFeatured() =>
      _mockProducts.where((p) => p.rating >= 4.5).toList();

  Product? getById(int id) {
    try {
      return _mockProducts.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  final List<Product> _mockProducts = [
    Product(
      id: 1,
      name: 'Wireless Noise-Cancelling Headphones',
      description:
          'Premium audio experience with 30-hour battery life, active noise cancellation, and comfortable over-ear design. Perfect for work and travel.',
      price: 199.99,
      originalPrice: 299.99,
      imageUrl: 'https://picsum.photos/seed/headphone/400/400',
      images: [
        'https://picsum.photos/seed/headphone1/400/400',
        'https://picsum.photos/seed/headphone2/400/400',
        'https://picsum.photos/seed/headphone3/400/400',
      ],
      category: 'Electronics',
      rating: 4.8,
      reviewCount: 1243,
      colors: ['Black', 'White', 'Navy'],
    ),
    Product(
      id: 2,
      name: 'Smart Watch Pro',
      description:
          'Track your fitness, receive notifications, and monitor your health with this advanced smartwatch. Water-resistant up to 50 meters.',
      price: 249.99,
      originalPrice: 349.99,
      imageUrl: 'https://picsum.photos/seed/watch/400/400',
      images: [
        'https://picsum.photos/seed/watch1/400/400',
        'https://picsum.photos/seed/watch2/400/400',
      ],
      category: 'Electronics',
      rating: 4.6,
      reviewCount: 892,
      colors: ['Black', 'Silver', 'Gold'],
    ),
    Product(
      id: 3,
      name: 'Premium Cotton T-Shirt',
      description:
          'Ultra-soft 100% organic cotton t-shirt with a relaxed fit. Breathable and comfortable for everyday wear.',
      price: 29.99,
      imageUrl: 'https://picsum.photos/seed/tshirt/400/400',
      category: 'Fashion',
      rating: 4.4,
      reviewCount: 567,
      sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
      colors: ['White', 'Black', 'Gray', 'Navy', 'Red'],
    ),
    Product(
      id: 4,
      name: 'Running Shoes Ultra',
      description:
          'Lightweight and responsive running shoes with advanced cushioning technology. Ideal for long-distance running and training.',
      price: 129.99,
      originalPrice: 179.99,
      imageUrl: 'https://picsum.photos/seed/shoes/400/400',
      category: 'Sports',
      rating: 4.7,
      reviewCount: 2341,
      sizes: ['40', '41', '42', '43', '44', '45'],
      colors: ['Black/Red', 'White/Blue', 'Gray/Green'],
    ),
    Product(
      id: 5,
      name: 'Minimalist Desk Lamp',
      description:
          'Modern LED desk lamp with adjustable brightness and color temperature. USB charging port included.',
      price: 49.99,
      imageUrl: 'https://picsum.photos/seed/lamp/400/400',
      category: 'Home',
      rating: 4.5,
      reviewCount: 423,
      colors: ['White', 'Black', 'Gold'],
    ),
    Product(
      id: 6,
      name: 'Vitamin C Serum',
      description:
          'Brightening vitamin C serum with hyaluronic acid and niacinamide. Reduces dark spots and improves skin texture.',
      price: 39.99,
      originalPrice: 59.99,
      imageUrl: 'https://picsum.photos/seed/serum/400/400',
      category: 'Beauty',
      rating: 4.9,
      reviewCount: 3102,
    ),
    Product(
      id: 7,
      name: 'Wireless Charging Pad',
      description:
          'Fast wireless charging pad compatible with all Qi-enabled devices. Slim design with LED indicator.',
      price: 34.99,
      imageUrl: 'https://picsum.photos/seed/charger/400/400',
      category: 'Electronics',
      rating: 4.3,
      reviewCount: 788,
      colors: ['Black', 'White'],
    ),
    Product(
      id: 8,
      name: 'Yoga Mat Premium',
      description:
          'Non-slip eco-friendly yoga mat with alignment lines. Extra thick 6mm cushioning for joint support.',
      price: 59.99,
      originalPrice: 79.99,
      imageUrl: 'https://picsum.photos/seed/yoga/400/400',
      category: 'Sports',
      rating: 4.6,
      reviewCount: 1567,
      colors: ['Purple', 'Blue', 'Green', 'Black'],
    ),
    Product(
      id: 9,
      name: 'Leather Crossbody Bag',
      description:
          'Genuine leather crossbody bag with multiple compartments. Perfect for daily use and travel.',
      price: 89.99,
      originalPrice: 129.99,
      imageUrl: 'https://picsum.photos/seed/bag/400/400',
      category: 'Fashion',
      rating: 4.5,
      reviewCount: 934,
      colors: ['Brown', 'Black', 'Tan'],
    ),
    Product(
      id: 10,
      name: 'Scented Soy Candle Set',
      description:
          'Hand-poured soy wax candles in three relaxing scents: lavender, vanilla, and eucalyptus.',
      price: 44.99,
      imageUrl: 'https://picsum.photos/seed/candle/400/400',
      category: 'Home',
      rating: 4.8,
      reviewCount: 2189,
    ),
  ];
}
