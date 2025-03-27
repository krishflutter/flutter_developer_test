import 'package:flutter/material.dart';
import 'package:main_games_test/exercise_1/exercise_1.dart';
import 'package:main_games_test/exercise_3/exercise_3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // showPerformanceOverlay: true,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'MainGames test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildButton(
              title: "exercise 1",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return const Exercise1Widget(
                    key: ValueKey('Exercise1'),
                  );
                }));
              },
            ),
            const SizedBox(height: 10),
            _buildButton(
              title: "exercise 3",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return const Exercise3Widget(
                    key: ValueKey('Exercise3'),
                  );
                }));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    String title = 'Press me',
    VoidCallback? onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(title),
    );
  }
}
