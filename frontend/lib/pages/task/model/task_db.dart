import '../../../store/db/app_db.dart';
import './TaskEntity.dart';
import 'package:sqflite/sqflite.dart';

class TaskDB {
  static final TaskDB _taskDb = TaskDB._internal(AppDatabase.get());

  AppDatabase _appDatabase;

  //private internal constructor to make it singleton
  TaskDB._internal(this._appDatabase);

  //static TaskDB get taskDb => _taskDb;

  static TaskDB get() {
    return _taskDb;
  }

  Future<List<Task>> getTasks(
      {int startDate = 0, int endDate = 0, TaskStatus taskStatus}) async {
    var db = await _appDatabase.getDb();
    var whereClause = startDate > 0 && endDate > 0
        ? "WHERE ${Task.tblTask}.${Task.dbDueDate} BETWEEN $startDate AND $endDate"
        : "";

    if (taskStatus != null) {
      var taskWhereClause =
          "${Task.tblTask}.${Task.dbStatus} = ${taskStatus.index}";
      whereClause = whereClause.isEmpty
          ? "WHERE $taskWhereClause"
          : "$whereClause AND $taskWhereClause";
    }

    var result = await db.rawQuery(
        'SELECT ${Task.tblTask}.* '
        'FROM ${Task.tblTask} $whereClause ');
        //'SELECT ${Tasks.tblTask}.*,${Project.tblProject}.${Project.dbName},${Project.tblProject}.${Project.dbColorCode},group_concat(${Label.tblLabel}.${Label.dbName}) as labelNames '
        //'FROM ${Tasks.tblTask} LEFT JOIN ${TaskLabels.tblTaskLabel} ON ${TaskLabels.tblTaskLabel}.${TaskLabels.dbTaskId}=${Tasks.tblTask}.${Tasks.dbId} '
        //'LEFT JOIN ${Label.tblLabel} ON ${Label.tblLabel}.${Label.dbId}=${TaskLabels.tblTaskLabel}.${TaskLabels.dbLabelId} '
        //'INNER JOIN ${Project.tblProject} ON ${Tasks.tblTask}.${Tasks.dbProjectID} = ${Project.tblProject}.${Project.dbId} $whereClause GROUP BY ${Tasks.tblTask}.${Tasks.dbId} ORDER BY ${Tasks.tblTask}.${Tasks.dbDueDate} ASC;');

    return _bindData(result);
  }

  List<Task> _bindData(List<Map<String, dynamic>> result) {
    List<Task> tasks = List();
    for (Map<String, dynamic> item in result) {
      var myTask = Task.fromMap(item);
      //myTask.projectName = item[Project.dbName];
      //myTask.projectColor = item[Project.dbColorCode];
      //var labelComma = item["labelNames"];
      //if (labelComma != null) {
       // myTask.labelList = labelComma.toString().split(",");
      //}
      tasks.add(myTask);
    }
    return tasks;
  }

/*
  Future<List<Tasks>> getTasksByProject(int projectId,
      {TaskStatus status}) async {
    var db = await _appDatabase.getDb();
    String whereStatus = status != null
        ? "AND ${Tasks.tblTask}.${Tasks.dbStatus}=${status.index}"
        : "";
    var result = await db.rawQuery(
      
        'SELECT ${Tasks.tblTask}.*,${Project.tblProject}.${Project.dbName},${Project.tblProject}.${Project.dbColorCode},group_concat(${Label.tblLabel}.${Label.dbName}) as labelNames '
        'FROM ${Tasks.tblTask} LEFT JOIN ${TaskLabels.tblTaskLabel} ON ${TaskLabels.tblTaskLabel}.${TaskLabels.dbTaskId}=${Tasks.tblTask}.${Tasks.dbId} '
        'LEFT JOIN ${Label.tblLabel} ON ${Label.tblLabel}.${Label.dbId}=${TaskLabels.tblTaskLabel}.${TaskLabels.dbLabelId} '
        'INNER JOIN ${Project.tblProject} ON ${Tasks.tblTask}.${Tasks.dbProjectID} = ${Project.tblProject}.${Project.dbId} WHERE ${Tasks.tblTask}.${Tasks.dbProjectID}=$projectId $whereStatus GROUP BY ${Tasks.tblTask}.${Tasks.dbId} ORDER BY ${Tasks.tblTask}.${Tasks.dbDueDate} ASC;');
        
    return _bindData(result);
  }

  Future<List<Tasks>> getTasksByLabel(String labelName,
      {TaskStatus status}) async {
    var db = await _appDatabase.getDb();
    String whereStatus = status != null
        ? "AND ${Tasks.tblTask}.${Tasks.dbStatus}=${TaskStatus.PENDING.index}"
        : "";
    var result = await db.rawQuery(
        'SELECT ${Tasks.tblTask}.*,${Project.tblProject}.${Project.dbName},${Project.tblProject}.${Project.dbColorCode},group_concat(${Label.tblLabel}.${Label.dbName}) as labelNames FROM ${Tasks.tblTask} LEFT JOIN ${TaskLabels.tblTaskLabel} ON ${TaskLabels.tblTaskLabel}.${TaskLabels.dbTaskId}=${Tasks.tblTask}.${Tasks.dbId} '
        'LEFT JOIN ${Label.tblLabel} ON ${Label.tblLabel}.${Label.dbId}=${TaskLabels.tblTaskLabel}.${TaskLabels.dbLabelId} '
        'INNER JOIN ${Project.tblProject} ON ${Tasks.tblTask}.${Tasks.dbProjectID} = ${Project.tblProject}.${Project.dbId} WHERE ${Tasks.tblTask}.${Tasks.dbProjectID}=${Project.tblProject}.${Project.dbId} $whereStatus GROUP BY ${Tasks.tblTask}.${Tasks.dbId} having labelNames LIKE "%$labelName%" ORDER BY ${Tasks.tblTask}.${Tasks.dbDueDate} ASC;');

    return _bindData(result);
  }
  */
  Future deleteTask(int taskID) async {
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawDelete(
          'DELETE FROM ${Task.tblTask} WHERE ${Task.dbId}=$taskID;');
    });
  }

  Future updateTaskStatus(int taskID, TaskStatus status) async {
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery(
          "UPDATE ${Task.tblTask} SET ${Task.dbStatus} = '${status.index}' WHERE ${Task.dbId} = '$taskID'");
    });
  }

  /// Inserts or replaces the task.
  Future updateTask(Task task, {List<int> labelIDs}) async {
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert('INSERT OR REPLACE INTO '
          '${Task.tblTask}(${Task.dbId},${Task.dbTitle},${Task.dbProjectID},${Task.dbComment},${Task.dbDueDate},${Task.dbPriority},${Task.dbStatus})'
          ' VALUES(${task.id}, "${task.title}", ${task.projectId},"${task.comment}", ${task.dueDate},${task.priority.index},${task.tasksStatus.index})');
      /*if (id > 0 && labelIDs != null && labelIDs.length > 0) {
        labelIDs.forEach((labelId) {
          txn.rawInsert('INSERT OR REPLACE INTO '
              '${TaskLabels.tblTaskLabel}(${TaskLabels.dbId},${TaskLabels.dbTaskId},${TaskLabels.dbLabelId})'
              ' VALUES(null, $id, $labelId)');
        });
      }*/ 
    });
  }
}
