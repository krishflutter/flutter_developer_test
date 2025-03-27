import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:main_games_test/exercise_3/exercise_3.dart';

void main() {
  testWidgets(
      'Displays error when password is invalid (less than 8 characters)',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Exercise3Widget()));

    await tester.enterText(
        find.byKey(const Key("usernameField")), "test@example.com");
    await tester.enterText(find.byKey(const Key("passwordField")), "123@567");
    await tester.tap(find.byKey(const Key("loginButton")));

    await tester.pump();

    expect(
        find.text(
            "Password must be at least 8 characters and contain at least one special character."),
        findsOneWidget);
  });

  testWidgets(
      'Displays error when password is invalid (without special character)',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Exercise3Widget()));

    await tester.enterText(
        find.byKey(const Key("usernameField")), "test@example.com");
    await tester.enterText(find.byKey(const Key("passwordField")), "123456789");
    await tester.tap(find.byKey(const Key("loginButton")));

    await tester.pump();

    expect(
        find.text(
            "Password must be at least 8 characters and contain at least one special character."),
        findsOneWidget);
  });

  testWidgets('Displays error when login fails', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Exercise3Widget()));

    await tester.enterText(
        find.byKey(const Key("usernameField")), "wrong@example.com");
    await tester.enterText(find.byKey(const Key("passwordField")), "Wrong@123");
    await tester.tap(find.byKey(const Key("loginButton")));

    await tester.pump(const Duration(seconds: 2));

    expect(find.text("Invalid username or password."), findsOneWidget);
  });

  testWidgets('Shows success dialog when login succeeds',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Exercise3Widget()));

    await tester.enterText(
        find.byKey(const Key("usernameField")), "test@example.com");
    await tester.enterText(find.byKey(const Key("passwordField")), "Pass@123");
    await tester.tap(find.byKey(const Key("loginButton")));

    await tester.pumpAndSettle();

    expect(find.text("Login successful!"), findsOneWidget);
  });

  testWidgets('Shows loading indicator during login',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Exercise3Widget()));

    await tester.enterText(
        find.byKey(const Key("usernameField")), "test@example.com");
    await tester.enterText(find.byKey(const Key("passwordField")), "Pass@123");

    await tester.tap(find.byKey(const Key("loginButton")));

    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
