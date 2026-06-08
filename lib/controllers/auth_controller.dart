import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final authService = AuthService();

  final Rx<User?> user = Rx<User?>(null);
  final RxBool isLoading = RxBool(false);
  final RxBool isLoggedIn = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  // Check if user is logged in
  void checkAuthStatus() {
    final currentUser = authService.getCurrentUser();
    user(currentUser);
    isLoggedIn(authService.isLoggedIn());
  }

  // Register
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      isLoading(true);
      await authService.register(
        name: name,
        email: email,
        password: password,
      );

      // Auto login after register
      await login(email: email, password: password);
      return true;
    } catch (e) {
      Get.snackbar(
        'Registration Failed',
        e.toString(),
        duration: const Duration(seconds: 3),
      );
      return false;
    } finally {
      isLoading(false);
    }
  }

  // Login
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading(true);
      final loginUser = await authService.login(
        email: email,
        password: password,
      );

      user(loginUser);
      isLoggedIn(true);

      Get.snackbar(
        'Success',
        'Welcome back, ${loginUser.name}!',
        duration: const Duration(seconds: 2),
      );

      return true;
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        duration: const Duration(seconds: 3),
      );
      return false;
    } finally {
      isLoading(false);
    }
  }

  // Update profile
  Future<bool> updateProfile({
    required String name,
    String? phone,
    String? profileImage,
  }) async {
    try {
      isLoading(true);
      await authService.updateProfile(
        name: name,
        phone: phone,
        profileImage: profileImage,
      );

      // Refresh user data
      checkAuthStatus();

      Get.snackbar(
        'Success',
        'Profile updated successfully',
        duration: const Duration(seconds: 2),
      );

      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        duration: const Duration(seconds: 3),
      );
      return false;
    } finally {
      isLoading(false);
    }
  }

  // Logout
  Future<bool> logout() async {
    try {
      isLoading(true);
      await authService.logout();
      user(null);
      isLoggedIn(false);

      Get.snackbar(
        'Success',
        'Logged out successfully',
        duration: const Duration(seconds: 1),
      );

      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        duration: const Duration(seconds: 2),
      );
      return false;
    } finally {
      isLoading(false);
    }
  }

  // Delete account
  Future<bool> deleteAccount() async {
    try {
      isLoading(true);
      await authService.deleteAccount();
      user(null);
      isLoggedIn(false);

      Get.snackbar(
        'Success',
        'Account deleted successfully',
        duration: const Duration(seconds: 1),
      );

      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        duration: const Duration(seconds: 2),
      );
      return false;
    } finally {
      isLoading(false);
    }
  }
}
