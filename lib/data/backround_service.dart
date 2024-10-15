import 'package:background_fetch/background_fetch.dart';

void backgroundFetchHeadlessTask(String taskId) async {
  await BackgroundFetch.finish(taskId);
}

void initializeBackgroundFetch() {
  BackgroundFetch.configure(BackgroundFetchConfig(
    minimumFetchInterval: 1,
    stopOnTerminate: false,
    enableHeadless: true,
  ), (taskId) {


    print("Background fetch triggered with taskId: $taskId");
    backgroundFetchHeadlessTask(taskId);
  });
}
