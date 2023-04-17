import 'package:financecontrol/components/customappbar.dart';
import 'package:flutter/material.dart';

import '../expenses/expenses_tab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppBar(
        title: Text('Bem vindo'),
      ),
      body: ExpensesTab(),
    );
  }
}
