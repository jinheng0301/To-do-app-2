import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:todooo/extensions/space_exs.dart';
import 'package:todooo/utils/app_colors.dart';
import 'package:todooo/utils/app_string.dart';
import 'package:todooo/view/tasks/components/task_view_app_bar.dart';
import 'package:todooo/view/tasks/widgets/date_time_selection_widget.dart';
import 'package:todooo/view/tasks/widgets/repeat%20_textfield.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final TextEditingController titleTaskController = TextEditingController();
  final TextEditingController descriptionTaskController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: TaskViewAppBar(),

        // Body
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Top Side Texts
                _buildTopSideTexts(textTheme),

                // Main task view activity
                buildMainTaskViewActivity(textTheme, context),

                // Bottom side button
                _buildBottomSideButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildBottomSideButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Delete currentn task button
          MaterialButton(
            onPressed: () {
              print('tapped');
            },
            height: 60,
            minWidth: 150,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.close,
                  color: AppColors.primaryColor,
                ),
                5.h,
                Text(
                  AppString.deleteTask,
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ],
            ),
          ),

          // Add or update task
          MaterialButton(
            onPressed: () {
              print('tapped');
            },
            height: 60,
            minWidth: 150,
            color: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Text(
                  AppString.addTaskString,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildMainTaskViewActivity(
      TextTheme textTheme, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 530,
      child: Column(
        children: [
          // Title of text field
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              AppString.titleOfTitleTextField,
              style: textTheme.headlineMedium,
            ),
          ),

          // task title
          repTextField(
            controller: titleTaskController,
            isForDescription: true,
          ),

          10.h,

          // Time selection
          DateTimeSelectionWidget(
            onTap: () {},
            title: AppString.timeString,
          ),

          // Date selection
          DateTimeSelectionWidget(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                minTime: DateTime(1900, 1, 1),
                maxTime: DateTime(2030, 12, 31),
                onChanged: (date) {
                  print('change $date');
                },
                onConfirm: (date) {
                  print('confirm $date');
                },
                currentTime: DateTime.now(),
                locale: LocaleType.en,
              );
            },
            title: AppString.dateString,
          ),
        ],
      ),
    );
  }

  Container _buildTopSideTexts(TextTheme textTheme) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Divider(
            thickness: 2,
          ),
          RichText(
            text: TextSpan(
              text: AppString.addNewTask,
              style: textTheme.titleLarge,
              children: [
                TextSpan(
                  text: AppString.taskString,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
