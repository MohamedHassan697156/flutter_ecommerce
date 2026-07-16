import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/product_model.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(const WishlistState());

  void toggle(Product product) {
    final items = List<Product>.from(state.items);
    if (isWishlisted(product.id)) {
      items.removeWhere((p) => p.id == product.id);
    } else {
      items.add(product);
    }
    emit(WishlistState(items: items));
  }

  bool isWishlisted(int productId) =>
      state.items.any((p) => p.id == productId);
}
