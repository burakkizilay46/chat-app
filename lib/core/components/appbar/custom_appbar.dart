import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget>? actions;

  const CustomAppBar({Key? key, required this.title, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      actions: actions,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purpleAccent.shade400.withOpacity(0.5), // Başlangıç rengi
              Colors.deepPurple.shade900.withOpacity(0.5), // Bitiş rengi
            ],
          ),
        ),
      ),
      // Burada AppBar'ınızı özelleştirebilirsiniz.
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
