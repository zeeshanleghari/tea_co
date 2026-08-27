import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tea_co/Screen/profile_screen.dart';
import 'package:tea_co/Screen/cart_screen.dart';
import 'package:tea_co/Screen/catalog_screen.dart';
import 'package:tea_co/controller/product_controller.dart';
import 'package:tea_co/model/product_model.dart';
import 'package:tea_co/widgets/ProductCard.dart';
import 'package:tea_co/widgets/home_banner.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = Supabase.instance.client.auth.currentUser;
  String get name => user?.userMetadata?['name'] ?? "Guest";

  final ProductController controller = ProductController();
  Future<List<ProductModel>>? _productsFuture;

  int _currentBottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _productsFuture = controller.getProducts();
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good Morning ☀️";
    if (hour < 17) return "Good Afternoon ☕";
    return "Good Evening 🌙";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: const Color(
                        0xFF2D6A4F,
                      ).withOpacity(0.12),
                      child: const Icon(
                        Icons.person,
                        color: Color(0xFF2D6A4F),
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _getGreeting(),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          name.toUpperCase(),
                          style: const TextStyle(
                            color: Color(0xFF2B2D42),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      color: Color(0xFF2B2D42),
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF2D6A4F),
                strokeWidth: 2.5,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Error loading products: ${snapshot.error}",
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ),
            );
          }

          final allProducts = snapshot.data ?? [];

          switch (_currentBottomNavIndex) {
            case 1:
              return CatalogScreen(products: allProducts);
            case 2:
              return const CartScreen();
            case 3:
              return const ProfileScreen();
            default:
              return _buildHomeContent(allProducts);
          }
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2D6A4F).withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: GNav(
            selectedIndex: _currentBottomNavIndex,
            onTabChange: (index) =>
                setState(() => _currentBottomNavIndex = index),
            gap: 4,
            activeColor: const Color(0xFF2D6A4F),
            iconSize: 20,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            duration: const Duration(milliseconds: 300),
            tabBackgroundColor: const Color(0xFF2D6A4F).withOpacity(0.12),
            color: const Color(0xFF8D99AE),
            textStyle: const TextStyle(
              color: Color(0xFF2D6A4F),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            tabs: const [
              GButton(icon: Icons.home_rounded, text: 'Home'),
              GButton(icon: Icons.grid_view_rounded, text: 'Catalog'),
              GButton(icon: Icons.shopping_bag_rounded, text: 'Cart'),
              GButton(icon: Icons.person_rounded, text: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeContent(List<ProductModel> allProducts) {
    final displayedProducts = allProducts.take(4).toList();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeBanner(),
          const SizedBox(height: 18),

          // Popular Products Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Popular Products",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2B2D42),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _currentBottomNavIndex = 1;
                  });
                },
                child: const Text(
                  "See All",
                  style: TextStyle(
                    color: Color(0xFF2D6A4F),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Product Grid
          displayedProducts.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.emoji_food_beverage_outlined,
                          size: 48,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "No tea items found",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: displayedProducts.length,
                  itemBuilder: (context, index) {
                    final item = displayedProducts[index];
                    return Productcard(item: item);
                  },
                ),

          if (allProducts.length > 4) ...[
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF2D6A4F), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _currentBottomNavIndex = 1;
                  });
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Explore Catalog",
                      style: TextStyle(
                        color: Color(0xFF2D6A4F),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: Color(0xFF2D6A4F),
                    ),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
