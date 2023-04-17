import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class NavigationTabs {
  static const int home = 0;
  static const int market = 1;
  static const int creditCard = 2;
  static const int profile = 3;
}

class NavigationController extends GetxController {
  //Variável que obterá dados futuramente, entretanto jamais será nullable
  late PageController _pageController;
  late RxInt _currentIndex;

  //Permite que outros arquivos do projeto acessem estes objetos
  PageController get pageController => _pageController;
  int get currentIndex => _currentIndex.value;

  @override
  void onInit() {
    super.onInit();
    _initNavigation(
        pageController: PageController(initialPage: NavigationTabs.home),
        currentIndex: NavigationTabs.home);
  }

  void _initNavigation({
    required PageController pageController,
    required int currentIndex,
  }) {
    _currentIndex = currentIndex.obs;
    _pageController = pageController;
  }

  void navigatePageView(int page) {
    if (_currentIndex.value == page) return;

    _pageController.jumpToPage(page);
    _currentIndex.value = page;
  }
}
