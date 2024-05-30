import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todooo/extensions/space_exs.dart';
import 'package:todooo/utils/app_colors.dart';
import 'package:todooo/utils/app_string.dart';
import 'package:todooo/view/home/widgets/fab.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,

      // Body
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            // Custom app bar
            Container(
              margin: EdgeInsets.only(top: 60),
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
            Padding(
              padding: const EdgeInsets.only(top: 10),
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
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return AnimatedContainer(
                      margin: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      duration: Duration(milliseconds: 600),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.1),
                            offset: Offset(0, 4),
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
                            duration: Duration(milliseconds: 600),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey,
                                width: .8,
                              ),
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // Task title
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 5, top: 3),
                          child: Text(
                            'Done',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),

                        // Task description
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Descriptions',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                              ),
                            ),

                            // Data of task
                            Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Date',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    'SubDate',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      // FAB
      floatingActionButton: FAB(),
    );
  }
}
