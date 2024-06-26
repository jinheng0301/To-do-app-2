import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todooo/extensions/space_exs.dart';
import 'package:todooo/utils/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  /// Icons
  List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.person_fill,
    CupertinoIcons.settings,
    CupertinoIcons.info_circle_fill,
  ];

  /// Texts
  List<String> texts = [
    "Home",
    "Profile",
    "Settings",
    "Details",
  ];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 90),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.primaryGradientColor,
          begin: Alignment.topLeft,
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
          ),
          8.h,
          Text(
            'JinHeng',
            style: textTheme.displayMedium,
          ),
          Text(
            'flutter developer',
            style: textTheme.displaySmall,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            width: double.infinity,
            height: 300,
            child: ListView.builder(
              itemCount: icons.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print('${texts[index]} tapped');
                  },
                  child: ListTile(
                    leading: Icon(icons[index]),
                    title: Text(texts[index]),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
