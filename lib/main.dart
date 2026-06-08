import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'constants/app_colors.dart';
import 'controllers/auth_controller.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() async {
  await GetStorage.init();
  runApp(const FashionShopApp());
}

class FashionShopApp extends StatelessWidget {
  const FashionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The HN',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
        primaryColor: AppColors.primary,
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Obx(
      () => authController.isLoggedIn.value ? HomeScreen() : const LoginScreen(),
    );
  }
}
