import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive/hive.dart';
import 'package:todooo/extensions/space_exs.dart';
import 'package:todooo/main.dart';
import 'package:todooo/models/task.dart';
import 'package:todooo/utils/app_colors.dart';
import 'package:todooo/utils/app_string.dart';
import 'package:todooo/utils/constants.dart';
import 'package:todooo/view/components/custom_drawer.dart';
import 'package:todooo/view/components/home_app_bar.dart';
import 'package:todooo/view/widgets/fab.dart';
import 'package:todooo/view/widgets/task_widget.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

  // check value of circle indicator
  dynamic valueOfIndicator(List<Task> task) {
    if (task.isNotEmpty) {
      return task.length;
    } else {
      return 3;
    }
  }

  // check done tasks
  int checkDoneTask(List<Task> tasks) {
    int i = 0;
    for (Task doneTask in tasks) {
      if (doneTask.isCompleted) {
        i++;
      }
    }
    return i;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    final base = BaseWidget.of(context);

    return ValueListenableBuilder(
      valueListenable: base.dataStore.listenToTask(),
      builder: (context, Box<Task> box, Widget? child) {
        var tasks = box.values.toList();

        print('Tasks loaded: ${tasks.length}'); // Debug print

        // for sorting list by date
        tasks.sort((a, b) => a.createdAtDate.compareTo(b.createdAtDate));

        return Scaffold(
          backgroundColor: Colors.white,

          // Body
          body: SliderDrawer(
            key: drawerKey,
            isDraggable: false,
            animationDuration: 1000,

            // Drawer
            slider: CustomDrawer(),

            // Home app bar
            appBar: HomeAppBar(
              drawerKey: drawerKey,
            ),

            // Main body
            child: _buildHomeBody(theme, base, tasks),
          ),

          // FAB
          floatingActionButton: FAB(),
        );
      },
    );
  }

  SizedBox _buildHomeBody(TextTheme theme, BaseWidget base, List<Task> tasks) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          // Custom app bar
          Container(
            margin: const EdgeInsets.only(top: 60),
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Progress indicator
                SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    value: checkDoneTask(tasks) / valueOfIndicator(tasks),
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(
                      AppColors.primaryColor,
                    ),
                  ),
                ),
                25.w,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.mainTitle,
                      style: theme.displayLarge,
                    ),
                    3.h,
                    Text(
                      '${checkDoneTask(tasks)} of ${tasks.length} task',
                      style: theme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Divider
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(
              thickness: 2,
              indent: 100,
            ),
          ),

          // Tasks
          Expanded(
            child: SizedBox(
              height: 745,
              width: double.infinity,
              child: tasks.isNotEmpty
                  ? ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        // get single task for showing in the list
                        var task = tasks[index];

                        return Dismissible(
                          direction: DismissDirection.horizontal,
                          onDismissed: (direction) {
                            // remove current task from DB
                            base.dataStore.deleteTask(task: task);
                          },
                          background: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.delete_outline,
                                color: Colors.grey,
                              ),
                              8.w,
                              const Text(
                                AppString.deletedTask,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          key: Key(task.id),
                          child: TaskWidget(task: task),
                        );
                      },
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FadeInDown(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Lottie.asset(
                              lottieURL,
                              animate: tasks.isNotEmpty ? false : true,
                            ),
                          ),
                        ),
                        FadeInUp(
                          child: Text(
                            AppString.doneAllTask,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
