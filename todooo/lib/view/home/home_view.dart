import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:todooo/extensions/space_exs.dart';
import 'package:todooo/utils/app_colors.dart';
import 'package:todooo/utils/app_string.dart';
import 'package:todooo/utils/constants.dart';
import 'package:todooo/view/tasks/components/custom_drawer.dart';
import 'package:todooo/view/tasks/components/home_app_bar.dart';
import 'package:todooo/view/tasks/widgets/fab.dart';
import 'package:todooo/view/tasks/components/task_widget.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<int> testing = [];
  final GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

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
        child: _buildHomeBody(theme),
      ),

      // FAB
      floatingActionButton: const FAB(),
    );
  }

  SizedBox _buildHomeBody(TextTheme theme) {
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
                const SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    value: 1 / 3,
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
                      '1 of 3 task',
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
              child: testing.isNotEmpty
                  ? ListView.builder(
                      itemCount: testing.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          direction: DismissDirection.horizontal,
                          onDismissed: (direction) {
                            // remove current task from DB
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
                          key: Key(
                            index.toString(),
                          ),
                          child: const TaskWidget(),
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
                              animate: testing.isNotEmpty ? false : true,
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
