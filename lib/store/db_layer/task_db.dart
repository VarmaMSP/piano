import 'package:phenopod/model/task.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/store/store.dart';

class TaskDb extends TaskStore {
  TaskDao _taskDao;

  TaskDb({SqlDb sqlDb}) {
    _taskDao = TaskDao(sqlDb);
  }

  @override
  Future<void> save(Task task) {
    return _taskDao.saveTask(task);
  }

  @override
  Stream<List<Task>> watchReady() {
    return _taskDao.watchReady();
  }

  @override
  Future<void> setProgress(List<int> taskIds, TaskStatus status) {
    return _taskDao.setProgress(taskIds, status);
  }

  @override
  Future<void> delete(int taskId) {
    return _taskDao.deleteTask(taskId);
  }
}
