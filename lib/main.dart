import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/todo_provider.dart';
import 'package:todo_app/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            fontFamily: 'Raleway'),
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
      ),
    );
  }
}

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/images/splash.jpeg'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.jpeg',
                scale: 8,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'TODO',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w900,
                    fontSize: 50,
                    color: Colors.purple,
                    letterSpacing: 2,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
          const SizedBox(
            height: 150,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            style: TextButton.styleFrom(
                padding: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                side: const BorderSide(color: Colors.purple, width: 0.5)),
            child: const Text(
              'Get Started',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
