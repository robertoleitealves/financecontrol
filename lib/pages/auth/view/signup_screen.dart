import 'package:financecontrol/components/customcolors.dart';
import 'package:financecontrol/pages/auth/controller/auth_controller.dart';
import 'package:financecontrol/components/custom_text_field.dart';
import 'package:financecontrol/components/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/mask_formatters.dart';
import '../../../services/validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

AuthController _controller = Get.find<AuthController>();

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Novo usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                label: 'Nome',
                icon: Icons.person,
                controller: _controller.nameSignUpController,
                validator: Validators.nameValidator,
                padding: const EdgeInsets.symmetric(vertical: 8),
                // onChanged: (p0) => Validators.nameValidator(p0),
              ),
              CustomTextField(
                label: 'Username',
                icon: Icons.person,
                controller: _controller.usernameSignUpController,
                padding: const EdgeInsets.symmetric(vertical: 8),
                // onChanged: (p0) => Validators.nameValidator(p0),
              ),
              CustomTextField(
                label: 'Data de nascimento',
                icon: Icons.date_range,
                controller: _controller.birthdateController,
                inputFormatters: [MaskFormatter.dateMask],
                padding: const EdgeInsets.symmetric(vertical: 8),
                validator: Validators.dateValidator,
              ),
              CustomTextField(
                label: 'Telefone',
                icon: Icons.phone,
                controller: _controller.phoneNumberController,
                inputFormatters: [MaskFormatter.phoneMask],
                validator: Validators.phoneValidator,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              CustomTextField(
                label: 'CPF',
                icon: Icons.numbers,
                controller: _controller.cpfSignUpController,
                inputFormatters: [MaskFormatter.cpfMask],
                padding: const EdgeInsets.symmetric(vertical: 8),
                validator: Validators.cpfValidator,
              ),
              CustomTextField(
                label: 'Digite uma senha',
                icon: Icons.numbers,
                controller: _controller.passwordSignUpController,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              CustomTextField(
                label: 'Digite a senha novamente',
                icon: Icons.numbers,
                controller: _controller.passwordConfirmController,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _controller.signUp();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.customSwatchColor,
                    padding: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Cadastrar nova conta',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8.0),
                    backgroundColor: CustomColors.customContrastColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Voltar',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
