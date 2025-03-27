import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:main_games_test/exercise_3/exercise_3.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("Login Integration Tests", () {
    testWidgets("User can log in successfully", (tester) async {
      await tester.pumpWidget(const MaterialApp(home: Exercise3Widget()));

      await tester.enterText(
          find.byKey(const Key("usernameField")), "test@example.com");
      await tester.enterText(
          find.byKey(const Key("passwordField")), "Pass@123");

      await tester.tap(find.byKey(const Key("loginButton")));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.text("Login successful!"), findsOneWidget);

      await tester.tap(find.text("OK"));
      await tester.pumpAndSettle();

      expect(find.text("Login successful!"), findsNothing);
    });

    testWidgets("User enters wrong password and invalid password format",
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: Exercise3Widget()));

      await tester.enterText(
          find.byKey(const Key("usernameField")), "test@example.com");
      await tester.enterText(
          find.byKey(const Key("passwordField")), "wrongPass#");

      await tester.tap(find.byKey(const Key("loginButton")));
      await tester.pumpAndSettle();

      expect(find.text("Invalid username or password."), findsOneWidget);

      await tester.enterText(find.byKey(const Key("passwordField")), "short");

      await tester.tap(find.byKey(const Key("loginButton")));
      await tester.pumpAndSettle();

      expect(
          find.text(
              "Password must be at least 8 characters and contain at least one special character."),
          findsOneWidget);
    });

    testWidgets("Unexpected error during login", (tester) async {
      await tester.pumpWidget(const MaterialApp(home: Exercise3Widget()));

      await tester.enterText(find.byKey(const Key("usernameField")), "throw");
      await tester.enterText(
          find.byKey(const Key("passwordField")), "Pass@123");

      await tester.tap(find.byKey(const Key("loginButton")));
      await tester.pumpAndSettle();

      expect(
          find.text("Something went wrong. Please try again."), findsOneWidget);
    });
  });
}
