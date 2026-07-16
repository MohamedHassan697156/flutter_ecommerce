import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../data/models/product_model.dart';
import '../../bloc/cart/cart_cubit.dart';
import '../../bloc/wishlist/wishlist_cubit.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? _selectedSize;
  String? _selectedColor;
  int _currentImage = 0;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final images = [p.imageUrl, ...p.images];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            actions: [
              BlocBuilder<WishlistCubit, WishlistState>(
                builder: (context, _) {
                  final isW =
                      context.read<WishlistCubit>().isWishlisted(p.id);
                  return IconButton(
                    icon: Icon(
                        isW ? Icons.favorite : Icons.favorite_border,
                        color: isW ? AppColors.error : null),
                    onPressed: () =>
                        context.read<WishlistCubit>().toggle(p),
                  );
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  PageView.builder(
                    itemCount: images.length,
                    onPageChanged: (i) =>
                        setState(() => _currentImage = i),
                    itemBuilder: (_, i) => CachedNetworkImage(
                      imageUrl: images[i],
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (p.hasDiscount)
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: AppColors.error,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          '-${p.discountPercent.toInt()}% OFF',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Row(
                      children: List.generate(
                        images.length,
                        (i) => Container(
                          margin: const EdgeInsets.only(left: 4),
                          width: i == _currentImage ? 16 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: i == _currentImage
                                ? AppColors.primary
                                : AppColors.textMuted,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text('${p.rating}',
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      Text(' (${p.reviewCount} reviews)',
                          style: const TextStyle(
                              color: AppColors.textMuted, fontSize: 13)),
                      const Spacer(),
                      Text(p.category,
                          style: const TextStyle(
                              color: AppColors.primary, fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('\$${p.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary)),
                      const SizedBox(width: 10),
                      if (p.hasDiscount)
                        Text('\$${p.originalPrice!.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.textMuted,
                                decoration: TextDecoration.lineThrough)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Sizes
                  if (p.sizes.isNotEmpty) ...[
                    const Text('Size',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      children: p.sizes.map((s) {
                        final sel = s == _selectedSize;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedSize = s),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: sel
                                  ? AppColors.primary
                                  : AppColors.cardDark,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: sel
                                      ? AppColors.primary
                                      : AppColors.borderDark),
                            ),
                            child: Text(s,
                                style: TextStyle(
                                    color: sel
                                        ? Colors.white
                                        : AppColors.textMuted)),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Colors
                  if (p.colors.isNotEmpty) ...[
                    const Text('Color',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      children: p.colors.map((c) {
                        final sel = c == _selectedColor;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedColor = c),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: sel
                                  ? AppColors.primary
                                  : AppColors.cardDark,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: sel
                                      ? AppColors.primary
                                      : AppColors.borderDark),
                            ),
                            child: Text(c,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: sel
                                        ? Colors.white
                                        : AppColors.textMuted)),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],

                  const Text('Description',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(p.description,
                      style: const TextStyle(
                          color: AppColors.textMuted,
                          height: 1.6,
                          fontSize: 14)),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: AppColors.surfaceDark,
          border: Border(top: BorderSide(color: AppColors.borderDark)),
        ),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            final inCart =
                context.read<CartCubit>().isInCart(p.id);
            return ElevatedButton.icon(
              onPressed: () {
                context.read<CartCubit>().addToCart(
                      p,
                      size: _selectedSize,
                      color: _selectedColor,
                    );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${p.name} added to cart!'),
                    backgroundColor: AppColors.success,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart_outlined),
              label: Text(inCart ? 'Add More' : AppStrings.addToCart,
                  style: const TextStyle(fontSize: 16)),
            );
          },
        ),
      ),
    );
  }
}
