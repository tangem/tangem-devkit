import 'package:devkit/main.dart' as app;
import 'package:flutter_driver/driver_extension.dart';

void main() {
  // This line enables the extension.
  //enableFlutterDriverExtension();
  enableFlutterDriverExtension(handler: (command) async {
    switch (command) {
      case 'restart':
        app.main();
        return 'ok';
    }
    throw Exception('Unknown command');
  });

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}

// launch test -> prompt in terminal
// flutter drive --target=test_driver/app.dart
