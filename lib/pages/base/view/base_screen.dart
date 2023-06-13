import 'package:financecontrol/pages/home/home_screen.dart';
import 'package:financecontrol/profile/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/customcolors.dart';
import '../controller/navigation_controller.dart';

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
          const HomeScreen(),
          ProfileTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          height: 60,
          elevation: 5,
          notchMargin: 5,
          shape: const CircularNotchedRectangle(),
          color: CustomColors.customSwatchColor,
          child: Row(
            children: [
              _BottomBarButton(
                  icon: Icons.home,
                  text: 'Início',
                  index: 0,
                  controller: navigationController),
              _BottomBarButton(
                  icon: Icons.person,
                  text: 'Perfil',
                  index: 1,
                  controller: navigationController)
            ],
          )),
    );
  }
}

class _BottomBarButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final int index;
  final NavigationController controller;

  const _BottomBarButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.index,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Obx(
      () => Expanded(
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {
            controller.navigatePageView(index);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: controller.currentIndex == index
                    ? colorScheme.onPrimary
                    : colorScheme.primaryContainer,
              ),
              Text(
                text,
                style: TextStyle(
                  color: controller.currentIndex == index
                      ? colorScheme.onPrimary
                      : colorScheme.primaryContainer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
