import 'package:flutter/material.dart';
import 'package:main_games_test/exercise_3/logic/exercise_3_notifier.dart';

class Exercise3Widget extends StatefulWidget {
  const Exercise3Widget({super.key});

  @override
  State<Exercise3Widget> createState() => _Exercise3WidgetState();
}

class _Exercise3WidgetState extends State<Exercise3Widget> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _notifier = Exercise3Notifier();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _notifier.dispose();
    super.dispose();
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Success"),
        content: const Text("Login successful!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListenableBuilder(
          listenable: _notifier,
          builder: (context, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  key: const Key("usernameField"),
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: "Username"),
                ),
                const SizedBox(height: 10),
                TextField(
                  key: const Key("passwordField"),
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    errorText: _notifier.errorMessage.isNotEmpty
                        ? _notifier.errorMessage
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  key: const Key("loginButton"),
                  onPressed: _notifier.isLoading
                      ? null
                      : () {
                          final username = _usernameController.text;
                          final password = _passwordController.text;
                          _notifier.login(username, password).then((value) {
                            if (value) {
                              _showSuccessDialog(context);
                            }
                          });
                        },
                  child: _notifier.isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Login"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
