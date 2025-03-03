import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isShow = false.obs; // To toggle password visibility

  // Placeholder for your future login logic
  Future<void> loginUser() async {
    // TODO: Implement your authentication logic here later.

    // For now, just navigate to the SideBarPage.
    Get.offAll(() => MainScreen()); 
  }
}
