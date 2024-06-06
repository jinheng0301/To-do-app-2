import 'package:flutter/material.dart';
import 'package:todooo/models/task.dart';
import 'package:todooo/utils/app_colors.dart';
import 'package:intl/intl.dart';

class TaskWidget extends StatefulWidget {
  late final Task task;
  TaskWidget({required this.task});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  final TextEditingController _textEditingControllerForTitle = TextEditingController();
  final TextEditingController _textEditingControllerForSubtitle =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingControllerForTitle.text = widget.task.title;
    _textEditingControllerForSubtitle.text = widget.task.subtitle;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textEditingControllerForTitle.dispose();
    _textEditingControllerForSubtitle.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to task view to see task details
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        duration: const Duration(milliseconds: 600),
        decoration: BoxDecoration(
          color: widget.task.isCompleted
              ? AppColors.primaryColor.withOpacity(0.15)
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: ListTile(
          // Check icon
          leading: GestureDetector(
            onTap: () {
              // Check or uncheck the task
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              decoration: BoxDecoration(
                color: widget.task.isCompleted
                    ? AppColors.primaryColor.withOpacity(0.15)
                    : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey,
                  width: .8,
                ),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),

          // Task title
          title: Padding(
            padding: EdgeInsets.only(bottom: 5, top: 3),
            child: Text(
              _textEditingControllerForTitle.text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                decoration:
                    widget.task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
          ),

          // Task description
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _textEditingControllerForSubtitle.text,
                style: TextStyle(
                  color: widget.task.isCompleted
                      ? AppColors.primaryColor
                      : Colors.black,
                  fontWeight: FontWeight.w300,
                  decoration: widget.task.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),

              // Data of task
              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('hh:mm p').format(widget.task.createdAtDate),
                      style: TextStyle(
                        fontSize: 14,
                        color: widget.task.isCompleted
                            ? Colors.white
                            : Colors.grey,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMEd().format(widget.task.createdAtDate),
                      style: TextStyle(
                        fontSize: 12,
                        color: widget.task.isCompleted
                            ? Colors.white
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
