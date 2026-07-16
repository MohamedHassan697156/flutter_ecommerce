part of 'wishlist_cubit.dart';

class WishlistState extends Equatable {
  final List<Product> items;
  const WishlistState({this.items = const []});

  @override
  List<Object?> get props => [items];
}
