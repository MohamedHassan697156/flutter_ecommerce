import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_ecommerce/data/models/product_model.dart';
import 'package:flutter_ecommerce/presentation/bloc/cart/cart_cubit.dart';

void main() {
  late CartCubit cartCubit;

  const testProduct = Product(
    id: 1,
    name: 'Test Product',
    description: 'Test description',
    price: 99.99,
    originalPrice: 149.99,
    imageUrl: 'https://picsum.photos/400/400',
    category: 'Electronics',
    rating: 4.5,
    reviewCount: 100,
  );

  setUp(() => cartCubit = CartCubit());
  tearDown(() => cartCubit.close());

  group('CartCubit', () {
    test('initial state is empty', () {
      expect(cartCubit.state.items, isEmpty);
      expect(cartCubit.state.itemCount, 0);
      expect(cartCubit.state.totalPrice, 0.0);
    });

    blocTest<CartCubit, CartState>(
      'adds product to cart',
      build: () => CartCubit(),
      act: (c) => c.addToCart(testProduct),
      expect: () => [
        isA<CartState>().having((s) => s.items.length, 'length', 1),
      ],
    );

    blocTest<CartCubit, CartState>(
      'increases quantity on duplicate add',
      build: () => CartCubit(),
      act: (c) {
        c.addToCart(testProduct);
        c.addToCart(testProduct);
      },
      expect: () => [
        isA<CartState>().having((s) => s.items.first.quantity, 'qty', 1),
        isA<CartState>().having((s) => s.items.first.quantity, 'qty', 2),
      ],
    );

    blocTest<CartCubit, CartState>(
      'removes product from cart',
      build: () => CartCubit(),
      act: (c) {
        c.addToCart(testProduct);
        c.removeFromCart(testProduct.id);
      },
      expect: () => [
        isA<CartState>().having((s) => s.items.length, 'length', 1),
        isA<CartState>().having((s) => s.items.length, 'length', 0),
      ],
    );

    blocTest<CartCubit, CartState>(
      'clears cart',
      build: () => CartCubit(),
      act: (c) {
        c.addToCart(testProduct);
        c.clearCart();
      },
      expect: () => [
        isA<CartState>().having((s) => s.items.length, 'length', 1),
        isA<CartState>().having((s) => s.items.length, 'length', 0),
      ],
    );

    test('calculates total price correctly', () {
      cartCubit.addToCart(testProduct);
      cartCubit.increaseQuantity(testProduct.id);
      expect(cartCubit.state.totalPrice, closeTo(199.98, 0.01));
    });

    test('calculates savings correctly', () {
      cartCubit.addToCart(testProduct);
      expect(cartCubit.state.totalSavings, closeTo(50.0, 0.01));
    });
  });
}
