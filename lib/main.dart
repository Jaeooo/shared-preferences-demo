import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Preferences Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  TextEditingController counterController = TextEditingController();

  void _getSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    counterController.text = prefs.getInt('counter').toString() ?? '0';

    Fluttertoast.showToast(
        msg: 'Loaded counter value ${counterController.text}');
  }

  void _setSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt(
      'counter',
      int.parse(counterController.text),
    );

    Fluttertoast.showToast(
        msg: 'Saved counter value ${counterController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: counterController,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: _setSharedPreferences,
                  child: const Text('Save'),
                ),
                const SizedBox(width: 24),
                OutlinedButton(
                  onPressed: _getSharedPreferences,
                  child: const Text('Load'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
