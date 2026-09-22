import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../cart/presentaion/screens/cart_screen.dart';
import '../../../menu/presentaion/screens/menu_screen.dart';
import '../../../orders/presentaion/screens/order_screen.dart';
import '../../../profile/presentaion/screens/profile_screen.dart';
class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;


  static const List<_NavItem> _navItems = [
    _NavItem(label: 'Menu', icon: Icons.coffee_outlined, activeIcon: Icons.coffee),
    _NavItem(label: 'Orders', icon: Icons.receipt_long_outlined, activeIcon: Icons.receipt_long),
    _NavItem(label: 'Cart', icon: Icons.shopping_bag_outlined, activeIcon: Icons.shopping_bag),
    _NavItem(label: 'Profile', icon: Icons.person_outline, activeIcon: Icons.person),
  ];

  List<Widget> _pages = [
    MenuScreen(),
    OrdersScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  void _onTabSelected(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.trinary,
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: _BottomNavBar(
        items: _navItems,
        currentIndex: _currentIndex,

        onTap: _onTabSelected,
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;

  const _NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });
}


class _BottomNavBar extends StatelessWidget {
  final List<_NavItem> items;
  final int currentIndex;
  final dynamic onTap;

  const _BottomNavBar({
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final bool isSelected = index == currentIndex;

          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          isSelected ? item.activeIcon : item.icon,
                          color: isSelected ? Colors.white : AppColors.neutral,
                          size: 24,
                        ),

                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : AppColors.neutral,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

