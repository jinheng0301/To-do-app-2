import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todooo/data/hive_data_store.dart';
import 'package:todooo/models/task.dart';
import 'package:todooo/view/screens/home_view.dart';

Future<void> main() async {
  // init hive db before runApp
  await Hive.initFlutter();

  // register hive adapter
  Hive.registerAdapter<Task>(TaskAdapter());

  // open a box
  var box = await Hive.openBox<Task>(HiveDataStore.boxName);

  // delete data from previous day
  box.values.forEach((task) {
    if (task.createdAtTime.day != DateTime.now().day) {
      task.delete();
    } else {}
  });

  runApp(
    BaseWidget(
      child: const MyApp(),
    ),
  );
}

// InheritedWidget provides with a convenient way to pass data between widgets.
// we need some data from parent's widgets or grandparents widget
class BaseWidget extends InheritedWidget {
  final Widget child;
  final HiveDataStore dataStore = HiveDataStore();

  BaseWidget({Key? key, required this.child}) : super(key: key, child: child);

  static BaseWidget of(BuildContext context) {
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if (base != null) {
      return base;
    } else {
      throw StateError('Could not find ancesstor widget of type BaseWidget');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return false;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: Colors.black,
          fontSize: 45,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.w300,
        ),
        displayMedium: TextStyle(
          color: Colors.white,
          fontSize: 21,
        ),
        displaySmall: TextStyle(
          color: Color.fromARGB(255, 234, 234, 234),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        headlineMedium: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        headlineSmall: TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
        titleSmall: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        titleLarge: TextStyle(
          fontSize: 40,
          color: Colors.black,
          fontWeight: FontWeight.w300,
        ),
      )),
      home: HomeView(),
    );
  }
}
