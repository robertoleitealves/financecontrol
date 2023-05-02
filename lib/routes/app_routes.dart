import 'package:financecontrol/pages/creditcard/creditcard_screen.dart';
import 'package:financecontrol/pages/expenses/expense_screen.dart';
import 'package:financecontrol/pages/expenses/expenses_bindings.dart';

import 'package:get/get.dart';

import '../pages/auth/view/signin_screen.dart';
import '../pages/auth/view/signup_screen.dart';
import '../pages/base/base_screen.dart';
import '../pages/creditcard/credicard_binding.dart';
import '../pages/creditcard/creditcard_tab.dart';
import '../pages/expenses/expenses_tab.dart';

import '../pages/splash/splash_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
 
    GetPage(
      name: PagesRoute.creditCardRoute,
      page: () => CreditCardTab(),
      binding: CreditCardBinding(),
    ),
    GetPage(
      name: PagesRoute.creditCardSelectedRoute,
      page: () => CreditCardScreen(),
    ),
    GetPage(
        name: PagesRoute.expensesRoute,
        page: () => ExpensesTab(),
        binding: ExpensesBinding()),
    GetPage(
      name: PagesRoute.expenseSelectedRoute,
      page: () => ExpenseScreen(),
    ),
    GetPage(
      name: PagesRoute.splashRoute,
      page: () => const SplashScreen(),
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
  static String splashRoute = '/splash';
  static String baseRoute = '/';
}
