import 'package:flutter/material.dart';
import 'package:todooo/utils/app_string.dart';
import 'package:todooo/view/home/components/task_view_app_bar.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final TextEditingController titleTextEditingController =
      TextEditingController();
  final TextEditingController descriptionTextEditingController =
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

                SizedBox(
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

                      //
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          maxLines: 6,
                          cursorHeight: 60,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                          onFieldSubmitted: (value) {},
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _buildTopSideTexts(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 70,
            width: double.infinity,
            child: Divider(
              thickness: 2,
            ),
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
          SizedBox(
            height: 70,
            width: double.infinity,
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
