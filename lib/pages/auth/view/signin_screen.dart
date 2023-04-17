import 'package:financecontrol/pages/auth/controller/auth_controller.dart';
import 'package:financecontrol/pages/base/controller/navigation_controller.dart';
import 'package:financecontrol/components/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/customcolors.dart';
import '../../../routes/app_routes.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

@override
class _SignInScreenState extends State<SignInScreen> {
  final nameController = TextEditingController();

  final _controller = Get.find<AuthController>();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.47,
                alignment: Alignment.center,
                child: const Text(
                  'Financial Control',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextField(
                      icon: Icons.person,
                      label: 'Nome',
                      controller: _controller.nameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      icon: Icons.lock,
                      label: 'Senha',
                      controller: _controller.passwordController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.put(NavigationController());
                        Get.toNamed(PagesRoute.baseRoute);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.customSwatchColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text(
                        ' Entrar',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Esqueceu a senha? '),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(PagesRoute.signUpRoute);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.customSwatchColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        ' Criar conta',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
