import 'package:flutter/material.dart';
import 'package:todooo/models/task.dart';
import 'package:todooo/utils/app_colors.dart';
import 'package:todooo/view/screens/task_view.dart';

class FAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final titleTaskController = TextEditingController();
    final descriptionTaskController = TextEditingController();
    const Task? task = null;

    return GestureDetector(
      onTap: () {
        print('task view');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskView(
              titleTaskController: titleTaskController,
              descriptionTaskController: descriptionTaskController,
              task: task,
            ),
          ),
        );
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 10,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
