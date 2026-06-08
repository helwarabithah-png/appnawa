import 'package:get/get.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductController extends GetxController {
  // Observable variables
  final RxList<Product> products = RxList<Product>();
  final RxList<Product> favorites = RxList<Product>();
  final Rx<Product?> selectedProduct = Rx<Product?>(null);
  final RxBool isLoading = RxBool(false);
  final RxString searchQuery = RxString('');
  
  // Filter variables
  final RxDouble minPrice = RxDouble(0);
  final RxDouble maxPrice = RxDouble(200);
  final RxString sortBy = RxString('');
  final RxBool isFiltering = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    loadProducts();
    _loadPriceRange();
  }

  // Load price range
  Future<void> _loadPriceRange() async {
    try {
      final range = await ProductService.getPriceRange();
      minPrice(range['min'] ?? 0);
      maxPrice(range['max'] ?? 200);
    } catch (e) {
      // Handle error
    }
  }

  // Load all products
  Future<void> loadProducts() async {
    try {
      isLoading(true);
      final loadedProducts = await ProductService.getProducts();
      products.assignAll(loadedProducts);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load products: $e',
        duration: const Duration(seconds: 2),
      );
    } finally {
      isLoading(false);
    }
  }

  // Search and filter products
  Future<void> searchAndFilter() async {
    try {
      isLoading(true);
      final results = await ProductService.advancedSearch(
        query: searchQuery.value.isEmpty ? null : searchQuery.value,
        minPrice: minPrice.value,
        maxPrice: maxPrice.value,
        sortBy: sortBy.value.isEmpty ? null : sortBy.value,
      );
      products.assignAll(results);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Search failed: $e',
        duration: const Duration(seconds: 2),
      );
    } finally {
      isLoading(false);
    }
  }

  // Update search query and filter
  Future<void> updateSearchQuery(String query) async {
    searchQuery(query);
    await searchAndFilter();
  }

  // Update price filter
  Future<void> updatePriceFilter(double min, double max) async {
    minPrice(min);
    maxPrice(max);
    await searchAndFilter();
  }

  // Update sort
  Future<void> updateSort(String sort) async {
    sortBy(sort);
    await searchAndFilter();
  }

  // Reset filters
  Future<void> resetFilters() async {
    try {
      searchQuery('');
      final range = await ProductService.getPriceRange();
      minPrice(range['min'] ?? 0);
      maxPrice(range['max'] ?? 200);
      sortBy('');
      await loadProducts();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to reset filters: $e',
        duration: const Duration(seconds: 2),
      );
    }
  }

  // Get product detail
  Future<void> getProductDetail(String id) async {
    try {
      final product = await ProductService.getProductById(id);
      selectedProduct(product);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load product details: $e',
        duration: const Duration(seconds: 2),
      );
    }
  }

  // Check if any filter is active
  bool get hasActiveFilters {
    return searchQuery.value.isNotEmpty ||
        sortBy.value.isNotEmpty ||
        (minPrice.value != 0 || maxPrice.value != 200);
  }

  // Add to favorites
  void addToFavorites(Product product) {
    if (!favorites.contains(product)) {
      favorites.add(product);
      Get.snackbar(
        'Success',
        '${product.title} added to favorites',
        duration: const Duration(seconds: 1),
      );
    }
  }

  // Remove from favorites
  void removeFromFavorites(Product product) {
    favorites.remove(product);
    Get.snackbar(
      'Success',
      '${product.title} removed from favorites',
      duration: const Duration(seconds: 1),
    );
  }

  // Check if product is in favorites
  bool isFavorite(Product product) {
    return favorites.contains(product);
  }

  // Get total products
  int getTotalProducts() => products.length;

  // Get total favorites
  int getTotalFavorites() => favorites.length;
}
