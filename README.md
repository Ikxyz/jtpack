# JTPack

A comprehensive Flutter package that provides useful utilities, extensions, validation helpers, logging tools, and async handlers to enhance your Flutter development workflow.

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  jtpack: ^latest_version
```

## Features

### Extensions

Useful extensions on String, BuildContext, num, and DateTime classes.

```dart
import 'package:jtpack/modules/extensions.dart';

// String extensions
"hello world".capitalize; // "Hello World"
"camelCase".fromCamelToCapitalize; // " CamelCase"
"generated-string".generateID; // Returns a random 16-character string
"long string here".short; // "long s..."
"user@example.com".maskedEmail; // Returns masked email like "u***@example.com"

// BuildContext extensions
context.navigator; // Access Navigator.of(context)
context.textTheme; // Access Theme.of(context).textTheme

// num extensions
100.toMoney(); // "$100.00"
100.toMoney(symbol: "€"); // "€ 100.00"
10.height; // Returns 10% of screen height
10.width; // Returns 10% of screen width
10.spaceVertical; // SizedBox with 10 logical pixels height
10.spaceHorizontal; // SizedBox with 10 logical pixels width

// DateTime extensions
DateTime.now().monthInString; // "Jan", "Feb", etc.
DateTime.now().getDateTime; // "Jan 15, 2023 | 14:30"
```

### Utils

Utility functions for UI measurements, random ID generation, and more.

```dart
import 'package:jtpack/modules/utils.dart';

// Get dimensions based on screen size
getWidth(context, 50); // 50% of screen width
getHeight(context, 30); // 30% of screen height

// Format large numbers
numberToK(1500); // "1k"
numberToK(1500000); // "1m"

// Debugging
canDebugPrint("Debug message"); // Prints with "AppLog:" prefix

// Generate random values
generateNumber(6); // 6-digit random number
generateId(null, 10); // 10-character random string

// Show snackbar
showSankBar("Message"); // Shows a snackbar with the message
```

### Regex Validators

Input validation functions for various data types.

```dart
import 'package:jtpack/modules/regex.dart';

// Form validation
isNotNull(""); // Returns error message if empty
isPassword("pass"); // Error: "Password must be up to 8 characters"
isPassword("password123"); // Returns null (valid)
isEmail("user@example.com"); // Returns null (valid)
isEmail("invalid-email"); // Error message
isTel("+1234567890"); // Returns null (valid)
isPin("1234"); // Returns null (valid)
isOtp("123456"); // Returns null (valid)
isAccountNumber("1234567890"); // Returns null (valid)
isDate("25-12-2023"); // Returns null (valid)
```

### Logging

Structured logging system with different log levels and display options.

```dart
import 'package:jtpack/modules/log.dart';

// Create and display logs
Log("Operation successful", code: 200, logType: LogType.success).log(); // Logs to console
Log("Network error", code: 400, logType: LogType.network).show(context); // Shows as snackbar

// Log types
// LogType.network - For network-related logs
// LogType.input - For user input issues
// LogType.failed - For operation failures
// LogType.runtime - For runtime errors
// LogType.info - For informational messages
// LogType.success - For successful operations
// LogType.warning - For warning messages
```

### Async Handlers

Handle asynchronous operations with built-in error handling.

```dart
import 'package:jtpack/modules/async.dart';

// Handle HTTP requests with automatic error handling
Future<void> fetchData() async {
  try {
    final result = await AsyncHandler.httpRequest(() async {
      final response = await dio.get('https://api.example.com/data');
      return response.data;
    });

    // Handle successful result
    print(result);
  } catch (e) {
    // e is already a Log instance with formatted error message
    if (e is Log) {
      e.show(context);
    }
  }
}
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:jtpack/jtpack.dart';

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({Key? key}) : super(key: key);

  Future<void> _loginUser(BuildContext context, String email, String password) async {
    // Validate inputs
    final emailError = isEmail(email);
    final passwordError = isPassword(password);

    if (emailError != null || passwordError != null) {
      Log(emailError ?? passwordError!, code: 400).show(context);
      return;
    }

    try {
      final result = await AsyncHandler.httpRequest(() async {
        // Your API call here
        await Future.delayed(Duration(seconds: 2)); // Simulating network request
        return {"user": "John Doe", "token": "sample-token"};
      });

      Log("Login successful", code: 200, logType: LogType.success).show(context);
      // Handle successful login...

    } catch (e) {
      if (e is Log) {
        e.show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JTPack Example".capitalize),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.spaceVertical,
            Text("Welcome", style: context.textTheme.headlineMedium),
            20.spaceVertical,
            ElevatedButton(
              onPressed: () => _loginUser(context, "user@example.com", "password123"),
              child: Text("Login"),
            ),
            10.spaceVertical,
            Text("Today is: ${DateTime.now().getDateTime}"),
            10.spaceVertical,
            Text("Your balance: ${1250.75.toMoney()}"),
          ],
        ),
      ),
    );
  }
}
```

## License

MIT