import 'package:get/get.dart';

import '../pages/auth/view/signin_screen.dart';
import '../pages/auth/view/signup_screen.dart';
import '../pages/base/base_screen.dart';
import '../pages/creditcard/view/creditcard_tab.dart';

import '../pages/expenses/view/expenses_tab.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoute.creditCardRoute,
      page: () => CreditCardTab(),
    ),
    GetPage(
      name: PagesRoute.expensesRoute,
      page: () => ExpensesTab(),
    ),
    GetPage(
      name: PagesRoute.signInRoute,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: PagesRoute.baseRoute,
      page: () => BaseScreen(),
    ),
    GetPage(
      name: PagesRoute.signUpRoute,
      page: () => const SignUpScreen(),
    ),
  ];
}

abstract class PagesRoute {
  static String marketRoute = '/market';
  static String creditCardRoute = '/creditCard';
  static String expensesRoute = '/expenses';
  static String expenseSelectedRoute = '/expenseSelected';
  static String marketSelectedRoute = '/marketSelected';
  static String creditCardSelectedRoute = '/creditCardSelected';
  static String signInRoute = '/signin';
  static String signUpRoute = '/signup';
  static String baseRoute = '/';
}
