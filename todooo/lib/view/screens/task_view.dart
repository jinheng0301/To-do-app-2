import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:todooo/extensions/space_exs.dart';
import 'package:todooo/models/task.dart';
import 'package:todooo/utils/app_colors.dart';
import 'package:todooo/utils/app_string.dart';
import 'package:todooo/view/components/task_view_app_bar.dart';
import 'package:todooo/view/widgets/date_time_selection_widget.dart';
import 'package:todooo/view/widgets/repeat_textfield.dart';

class TaskView extends StatefulWidget {
  TaskView({
    required this.titleTaskController,
    required this.descriptionTaskController,
    required this.task,
  });

  final TextEditingController titleTaskController;
  final TextEditingController descriptionTaskController;
  final Task? task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  var title;
  var subTitle;
  DateTime? time;
  DateTime? date;

  // if any task already exsit then return true otherwise false
  bool isTaskAlreadyExist() {
    return widget.titleTaskController.text.isNotEmpty ||
        widget.descriptionTaskController.text.isNotEmpty;
  }

  // Show Selected Time As DateTime Format
  DateTime getInitialTime(DateTime? time) {
    return time ?? widget.task?.createdAtTime ?? DateTime.now();
  }

  String showTime(DateTime? time) {
    if (widget.task?.createdAtTime == null) {
      if (time == null) {
        return DateFormat('hh:mm a').format(DateTime.now()).toString();
      } else {
        return DateFormat('hh:mm a').format(time).toString();
      }
    } else {
      return DateFormat('hh:mm a')
          .format(widget.task!.createdAtTime)
          .toString();
    }
  }

  String showDate(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateFormat.yMMMEd().format(DateTime.now()).toString();
      } else {
        return DateFormat.yMMMEd().format(date).toString();
      }
    } else {
      return DateFormat.yMMMEd().format(widget.task!.createdAtDate).toString();
    }
  }

  DateTime showDateAsDateTime(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateTime.now();
      } else {
        return date;
      }
    } else {
      return widget.task!.createdAtDate;
    }
  }

  // Main function for creating or updating tasks
  dynamic isTaskAlreadyExistUpdateOtherwiseCreate() {
    if (widget.titleTaskController.text.isNotEmpty ||
        widget.descriptionTaskController.text.isNotEmpty) {
      try {} catch (e) {}
    }
  }

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
          // Delete current task button
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
          RepTextField(
            controller: widget.titleTaskController,
            isForDescription: true,
            onFieldSubmitted: (String inputTitle) {
              title = inputTitle;
            },
            onChanged: (String inputTitle) {
              title = inputTitle;
            },
          ),

          10.h,

          // task subTitle
          RepTextField(
            controller: widget.descriptionTaskController,
            isForDescription: true,
            onFieldSubmitted: (String inputSubTitle) {
              subTitle = inputSubTitle;
            },
            onChanged: (String inputSubTitle) {
              subTitle = inputSubTitle;
            },
          ),

          // Time selection
          DateTimeSelectionWidget(
            onTap: () {
              DatePicker.showTimePicker(context,
                  showTitleActions: true,
                  showSecondsColumn: false,
                  onChanged: (_) {}, onConfirm: (selectedTime) {
                setState(() {
                  if (widget.task?.createdAtTime == null) {
                    time = selectedTime;
                  } else {
                    widget.task!.createdAtTime = selectedTime;
                  }
                });

                FocusManager.instance.primaryFocus?.unfocus();
              }, currentTime: getInitialTime(time));
            },
            title: showTime(time),
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
            title: showDate(date),
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
              text: isTaskAlreadyExist()
                  ? AppString.addNewTask
                  : AppString.updateCurrentTask,
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
