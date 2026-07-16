import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/models/product_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void addToCart(Product product, {String? size, String? color}) {
    final items = List<CartItem>.from(state.items);
    final index = items.indexWhere(
      (i) =>
          i.product.id == product.id &&
          i.selectedSize == size &&
          i.selectedColor == color,
    );

    if (index >= 0) {
      items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
    } else {
      items.add(CartItem(
        product: product,
        selectedSize: size,
        selectedColor: color,
      ));
    }

    emit(state.copyWith(items: items));
  }

  void removeFromCart(int productId) {
    final items =
        state.items.where((i) => i.product.id != productId).toList();
    emit(state.copyWith(items: items));
  }

  void increaseQuantity(int productId) {
    final items = state.items.map((item) {
      if (item.product.id == productId) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();
    emit(state.copyWith(items: items));
  }

  void decreaseQuantity(int productId) {
    final items = state.items.map((item) {
      if (item.product.id == productId && item.quantity > 1) {
        return item.copyWith(quantity: item.quantity - 1);
      }
      return item;
    }).toList();
    emit(state.copyWith(items: items));
  }

  void clearCart() => emit(const CartState());

  bool isInCart(int productId) =>
      state.items.any((i) => i.product.id == productId);
}
