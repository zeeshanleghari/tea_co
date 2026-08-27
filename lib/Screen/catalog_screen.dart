import 'package:flutter/material.dart';
import 'package:tea_co/model/category_model.dart';
import 'package:tea_co/model/product_model.dart';
import 'package:tea_co/widgets/ProductCard.dart';

class CatalogScreen extends StatefulWidget {
  final List<ProductModel> products;

  const CatalogScreen({super.key, required this.products});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  int _selectedCategoryId = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<CategoryModel> _getCategories(List<ProductModel> products) {
    final Map<int, CategoryModel> categoryMap = {};
    for (var product in products) {
      final category = product.category;
      if (category != null && category.category.isNotEmpty) {
        categoryMap[category.id] = category;
      }
    }
    return [
      CategoryModel(id: 0, category: "All Categories"),
      ...categoryMap.values,
    ];
  }

  Map<CategoryModel, List<ProductModel>> _getGroupedProducts(
    List<CategoryModel> categories,
  ) {
    final Map<CategoryModel, List<ProductModel>> grouped = {};

    for (var cat in categories) {
      if (cat.id == 0) continue;

      final catProducts = widget.products.where((p) {
        final matchesCat = p.category?.id == cat.id;
        final matchesSearch =
            _searchQuery.trim().isEmpty ||
            p.title.toLowerCase().contains(_searchQuery.toLowerCase());
        return matchesCat && matchesSearch;
      }).toList();

      if (catProducts.isNotEmpty) {
        grouped[cat] = catProducts;
      }
    }
    return grouped;
  }

  List<ProductModel> _getFilteredProducts() {
    return widget.products.where((p) {
      final matchesCategory =
          _selectedCategoryId == 0 || p.category?.id == _selectedCategoryId;
      final matchesSearch =
          _searchQuery.trim().isEmpty ||
          p.title.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final categoryList = _getCategories(widget.products);
    final isSearchingOrFiltered =
        _searchQuery.trim().isNotEmpty || _selectedCategoryId != 0;
    final filteredProducts = _getFilteredProducts();
    final groupedProducts = _getGroupedProducts(categoryList);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Catalog & Categories 🍃",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2B2D42),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Search Bar Component
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.search_rounded,
                      color: Colors.grey.shade400,
                      size: 22,
                    ),
                    hintText: "Search in catalog...",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.clear_rounded,
                              color: Colors.grey.shade400,
                              size: 18,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = "");
                            },
                          )
                        : null,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Categories Filter Chips
            if (categoryList.isNotEmpty)
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryList.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final category = categoryList[index];
                    final isSelected = category.id == _selectedCategoryId;

                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(category.category),
                        selected: isSelected,
                        selectedColor: const Color(0xFF2D6A4F),
                        backgroundColor: Colors.white,
                        elevation: 0,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF2B2D42),
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w500,
                          fontSize: 13,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide(
                            color: isSelected
                                ? Colors.transparent
                                : Colors.grey.shade200,
                          ),
                        ),
                        showCheckmark: false,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() => _selectedCategoryId = category.id);
                          }
                        },
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(height: 12),

            Expanded(
              child: isSearchingOrFiltered
                  ? (filteredProducts.isEmpty
                        ? _buildEmptyState("No matching products found")
                        : GridView.builder(
                            padding: const EdgeInsets.all(16),
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.65,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                            itemCount: filteredProducts.length,
                            itemBuilder: (context, index) {
                              return Productcard(item: filteredProducts[index]);
                            },
                          ))
                  : (groupedProducts.isEmpty
                        ? _buildEmptyState("No catalog sections available")
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 20),
                            itemCount: groupedProducts.keys.length,
                            itemBuilder: (context, index) {
                              final category = groupedProducts.keys.elementAt(
                                index,
                              );
                              final categoryItems = groupedProducts[category]!;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 8.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          category.category,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF2B2D42),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _selectedCategoryId = category.id;
                                            });
                                          },
                                          child: const Text(
                                            "View All",
                                            style: TextStyle(
                                              color: Color(0xFF2D6A4F),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Category Row Height fixed to 280 (Overflow fixed)
                                  SizedBox(
                                    height: 280,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: categoryItems.length,
                                      itemBuilder: (context, itemIndex) {
                                        final item = categoryItems[itemIndex];
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            right: 12.0,
                                          ),
                                          child: SizedBox(
                                            width: 160,
                                            child: Productcard(item: item),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                ],
                              );
                            },
                          )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.grid_view_rounded, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text(
            message,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
