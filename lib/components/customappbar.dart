import 'package:financecontrol/components/customcolors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.actions,
    this.leading,
    this.title,
    this.automaticallyImplyLeading = false,
  });

  final List<Widget>? actions;
  final Widget? leading;
  final Widget? title;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: CustomColors.customSwatchColor,
      actions: [],
      titleTextStyle:
          const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      title: title,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55);
}
