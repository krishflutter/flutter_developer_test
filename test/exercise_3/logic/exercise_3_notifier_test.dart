import 'package:flutter_test/flutter_test.dart';
import 'package:main_games_test/exercise_3/logic/exercise_3_notifier.dart';

void main() {
  late Exercise3Notifier loginNotifier;

  setUp(() {
    loginNotifier = Exercise3Notifier();
  });

  test("Valid password passes validation", () {
    expect(loginNotifier.login("user", "Pass@123"), completion(isFalse));
  });

  test("Invalid password with less than 8 characters fails", () {
    loginNotifier.login("user", "Pass@1");
    expect(loginNotifier.errorMessage,
        "Password must be at least 8 characters and contain at least one special character.");
  });

  test("Invalid password without special character fails", () {
    loginNotifier.login("user", "Password123");
    expect(loginNotifier.errorMessage,
        "Password must be at least 8 characters and contain at least one special character.");
  });

  test("Invalid login credentials show error", () async {
    await loginNotifier.login("wrong@example.com", "Pass@123");
    expect(loginNotifier.errorMessage, "Invalid username or password.");
  });

  test("show something went wrong. Please try again.", () async {
    await loginNotifier.login("throw", "Pass@123");
    expect(
        loginNotifier.errorMessage, "Something went wrong. Please try again.");
  });

  test("Login success clears error message", () async {
    await loginNotifier.login("test@example.com", "Pass@123");
    expect(loginNotifier.errorMessage, "");
  });

  test("Login sets isLoading state correctly", () async {
    final future = loginNotifier.login("test@example.com", "Pass@123");

    expect(loginNotifier.isLoading, true);

    await future;
    expect(loginNotifier.isLoading, false);
  });

  test("Login success and return true", () {
    expect(loginNotifier.login("test@example.com", "Pass@123"),
        completion(isTrue));
  });
}
