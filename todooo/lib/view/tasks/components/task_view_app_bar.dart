import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TaskViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskViewAppBar({super.key});

  Size get preferredSize => Size.fromHeight(150);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_new_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
