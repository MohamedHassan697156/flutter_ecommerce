part of 'cart_cubit.dart';

class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({this.items = const []});

  int get itemCount => items.fold(0, (sum, i) => sum + i.quantity);

  double get totalPrice => items.fold(0.0, (sum, i) => sum + i.totalPrice);

  double get totalSavings => items.fold(
        0.0,
        (sum, i) => sum +
            (i.product.hasDiscount
                ? (i.product.originalPrice! - i.product.price) * i.quantity
                : 0),
      );

  CartState copyWith({List<CartItem>? items}) =>
      CartState(items: items ?? this.items);

  @override
  List<Object?> get props => [items];
}
