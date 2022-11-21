import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Native called background task: $task");
    print("inputData: $inputData");
    print("Now: ${DateTime.now()}");

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("test", true);
    print("Bool from prefs: ${prefs.getBool("test")}");
    // The task is successful.
    return Future.value(true);
  });
}
