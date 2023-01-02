import 'package:flutter/material.dart';
import 'home/home_page.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task List',
        theme: theme.copyWith(
          scaffoldBackgroundColor: Color.fromARGB(255, 210, 209, 217),
          colorScheme: theme.colorScheme.copyWith(
            primary: const Color.fromARGB(255, 8, 1, 55),
            secondary: const Color.fromARGB(255, 8, 1, 55),
          ),
        ),
        home: const Home()
        // routes: {
        //   '/': (context) => Loading(),
        //   '/home': (context) => Home(),
        //   '/'
        // }
        );
  }
}
