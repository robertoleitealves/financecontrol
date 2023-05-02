import 'package:financecontrol/profile/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/customcolors.dart';
import '../creditcard/creditcard_tab.dart';
import '../expenses/expenses_tab.dart';

import 'controller/navigation_controller.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({super.key});
  final navigationController = Get.find<NavigationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: navigationController.pageController,
        children: [
          ExpensesTab(),
          CreditCardTab(),
          const ProfileTab(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: navigationController.currentIndex,
          onTap: (index) {
            navigationController.navigatePageView(index);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: CustomColors.customSwatchColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withAlpha(100),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
 
            BottomNavigationBarItem(
                icon: Icon(Icons.credit_card), label: 'Cartões'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          ],
        ),
      ),
    );
  }
}
