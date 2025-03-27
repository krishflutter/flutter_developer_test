import 'dart:developer';

enum AuthErrorType {
  userCanceled,
  invalidCredentials,
  networkError;
}

class AuthException implements Exception {
  final AuthErrorType errorType;
  final String message;

  AuthException(this.errorType, this.message);
}

abstract class AuthMethod {
  Future<String> onLogin();
}

class GoogleAuth implements AuthMethod {
  @override
  Future<String> onLogin() async {
    try {
      // Fake gọi API Google Sign-In
      String token = "google_token";
      if (token.isEmpty) {
        throw AuthException(
            AuthErrorType.invalidCredentials, "Invalid Google credentials");
      }
      return token;
    } catch (e) {
      throw AuthException(
          AuthErrorType.networkError, "Google login failed: $e");
    }
  }
}

class FacebookAuth implements AuthMethod {
  @override
  Future<String> onLogin() async {
    try {
      // Fake gọi API Facebook Sign-In
      String token = "facebook_token";
      if (token.isEmpty) {
        throw AuthException(
            AuthErrorType.invalidCredentials, "Invalid Facebook credentials");
      }
      return token;
    } catch (e) {
      throw AuthException(
          AuthErrorType.networkError, "Facebook login failed: $e");
    }
  }
}

class EmailAuth implements AuthMethod {
  final String email;
  final String password;

  EmailAuth(this.email, this.password);

  @override
  Future<String> onLogin() async {
    try {
      // Fake gọi API xác thực email/password
      if (email == "admin@example.com" && password == "123456") {
        return "email_auth_token";
      } else {
        throw AuthException(
            AuthErrorType.invalidCredentials, "Invalid email or password");
      }
    } catch (e) {
      throw AuthException(AuthErrorType.networkError, "Email login failed: $e");
    }
  }
}

enum AuthMethodType {
  google,
  facebook,
  email;
}

class AuthFactory {
  static AuthMethod create(AuthMethodType method,
      {String? email, String? password}) {
    switch (method) {
      case AuthMethodType.google:
        return GoogleAuth();
      case AuthMethodType.facebook:
        return FacebookAuth();
      case AuthMethodType.email:
        if (email == null || password == null) {
          throw ArgumentError("Email and password are required for EmailAuth");
        }
        return EmailAuth(email, password);
    }
  }
}

void onLogin(AuthMethodType method, {String? email, String? password}) async {
  final authMethod =
      AuthFactory.create(method, email: email, password: password);
  try {
    String token = await authMethod.onLogin();
    log(token);
    showSuccess();
  } on AuthException catch (e) {
    if (e.errorType == AuthErrorType.userCanceled) {
      // print("Login was canceled by user.");
    } else if (e.errorType == AuthErrorType.invalidCredentials) {
      // print("Invalid login credentials.");
    } else {
      // print("Login error: ${e.message}");
    }
  }
}

void showSuccess() {}
