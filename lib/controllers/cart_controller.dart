import 'package:get/get.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartController extends GetxController {
  final RxList<CartItem> cartItems = RxList<CartItem>();

  // Get total price
  double get totalPrice {
    return cartItems.fold(0, (total, item) => total + item.totalPrice);
  }

  // Get total items count
  int get totalItemsCount {
    return cartItems.fold(0, (total, item) => total + item.quantity);
  }

  // Add to cart
  void addToCart(Product product, {int quantity = 1}) {
    try {
      final existingItem = cartItems.firstWhereOrNull((item) => item.product.id == product.id);

      if (existingItem != null) {
        existingItem.quantity += quantity;
        cartItems.refresh();
      } else {
        cartItems.add(CartItem(product: product, quantity: quantity));
      }

      Get.snackbar(
        'Success',
        '${product.title} added to cart',
        duration: const Duration(seconds: 1),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add to cart: $e',
        duration: const Duration(seconds: 2),
      );
    }
  }

  // Remove from cart
  void removeFromCart(Product product) {
    cartItems.removeWhere((item) => item.product.id == product.id);
    Get.snackbar(
      'Success',
      '${product.title} removed from cart',
      duration: const Duration(seconds: 1),
    );
  }

  // Update quantity
  void updateQuantity(Product product, int quantity) {
    if (quantity <= 0) {
      removeFromCart(product);
      return;
    }

    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      cartItems[index].quantity = quantity;
      cartItems.refresh();
    }
  }

  // Check if product is in cart
  bool isInCart(Product product) {
    return cartItems.any((item) => item.product.id == product.id);
  }

  // Get quantity of product in cart
  int getQuantity(Product product) {
    try {
      return cartItems.firstWhere((item) => item.product.id == product.id).quantity;
    } catch (e) {
      return 0;
    }
  }

  // Clear cart
  void clearCart() {
    cartItems.clear();
    Get.snackbar(
      'Success',
      'Cart cleared',
      duration: const Duration(seconds: 1),
    );
  }

  // Get cart items count
  int getCartItemsCount() => cartItems.length;
}
