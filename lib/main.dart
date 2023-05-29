import 'package:financecontrol/pages/auth/controller/auth_controller.dart';
import 'package:financecontrol/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.lazyPut(() => AuthController());

  runApp(const FinancialControl());
}

class FinancialControl extends StatelessWidget {
  const FinancialControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Financial Control',
      //Define as cores padrão do App
      theme: ThemeData(
        backgroundColor: Colors.blue[900],
        scaffoldBackgroundColor: Colors.white.withAlpha(190),
      ),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      initialRoute: PagesRoute.signInRoute,
    );
  }
}
