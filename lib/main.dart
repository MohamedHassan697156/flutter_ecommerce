import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'presentation/bloc/cart/cart_cubit.dart';
import 'presentation/bloc/wishlist/wishlist_cubit.dart';
import 'presentation/screens/home/home_screen.dart';
import 'presentation/screens/cart/cart_screen.dart';

void main() {
  runApp(const ShopFlowApp());
}

class ShopFlowApp extends StatelessWidget {
  const ShopFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (_) => WishlistCubit()),
      ],
      child: MaterialApp(
        title: 'ShopFlow',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.dark,
        home: const MainNavigation(),
        routes: {
          '/cart': (_) => const CartScreen(),
        },
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _index = 0;

  final _screens = const [
    HomeScreen(),
    CartScreen(),
    _WishlistScreen(),
    _ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, cartState) {
          return BottomNavigationBar(
            currentIndex: _index,
            onTap: (i) => setState(() => _index = i),
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home'),
              BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    const Icon(Icons.shopping_cart_outlined),
                    if (cartState.itemCount > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                              color: Color(0xFFEF4444),
                              shape: BoxShape.circle),
                          child: Text('${cartState.itemCount}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                  ],
                ),
                activeIcon: const Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_outline),
                  activeIcon: Icon(Icons.favorite),
                  label: 'Wishlist'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Profile'),
            ],
          );
        },
      ),
    );
  }
}

class _WishlistScreen extends StatelessWidget {
  const _WishlistScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_outline, size: 80, color: Color(0xFF6B6B85)),
                  SizedBox(height: 16),
                  Text('No favourites yet',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF6B6B85),
                          fontWeight: FontWeight.w600)),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.items.length,
            itemBuilder: (_, i) {
              final p = state.items[i];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  title: Text(p.name,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text('\$${p.price.toStringAsFixed(2)}',
                      style: const TextStyle(color: Color(0xFF4F8EF7))),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Color(0xFFEF4444)),
                    onPressed: () =>
                        context.read<WishlistCubit>().toggle(p),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Color(0xFF1E1E2E),
            child: Icon(Icons.person, size: 50, color: Color(0xFF4F8EF7)),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text('Mohamed Hassan',
                style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          ),
          const Center(
            child: Text('mohassangr@gmail.com',
                style: TextStyle(color: Color(0xFF6B6B85))),
          ),
          const SizedBox(height: 32),
          _ProfileTile(icon: Icons.shopping_bag_outlined, label: 'My Orders'),
          _ProfileTile(icon: Icons.location_on_outlined, label: 'Addresses'),
          _ProfileTile(icon: Icons.payment_outlined, label: 'Payment Methods'),
          _ProfileTile(icon: Icons.notifications_outlined, label: 'Notifications'),
          _ProfileTile(icon: Icons.help_outline, label: 'Help & Support'),
          _ProfileTile(icon: Icons.settings_outlined, label: 'Settings'),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ProfileTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF4F8EF7)),
        title: Text(label),
        trailing: const Icon(Icons.chevron_right, color: Color(0xFF6B6B85)),
        onTap: () {},
      ),
    );
  }
}
