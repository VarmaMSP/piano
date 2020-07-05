// import 'package:phenopod/model/main.dart';
// import 'package:phenopod/store/store.dart';
// import 'package:retry/retry.dart';

// class TaskRunner {
//   final Store store;

//   TaskRunner({this.store});

//   void init() {
//     store.taskQueue.watchFront().where((task) => task != null).listen(_runTask);
//   }

//   Future<void> _runTask(Task task) async {
//     await task.when(
//       cachePodcast: (data) async {
//         if (await store.podcast.isCached(urlParam: data.urlParam)) {
//           return;
//         }
//         final r = RetryOptions(
//           maxAttempts: 3,
//           delayFactor: Duration(seconds: 20),
//         );
//         await r.retry(() => store.podcast.cache(data.urlParam));
//       },
//     );
//     await store.taskQueue.pop();
//   }
// }
