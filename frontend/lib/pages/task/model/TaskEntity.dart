import '../../../store/model/priority.dart';
import 'package:meta/meta.dart';

class Task {
  static final tblTask = "Tasks";
  static final dbId = "id";
  static final dbTitle = "title";
  static final dbComment = "comment";
  static final dbDueDate = "dueDate";
  static final dbPriority = "priority";
  static final dbStatus = "status";
  static final dbProjectID = "projectId";

  String title, comment, projectName;
  int id, dueDate, projectId, projectColor;
  Status priority;
  TaskStatus tasksStatus;
  bool _completed;
  List<String> labelList = List();

  Task.create(
      {@required this.title,
      // @required this.projectId,
      this.comment = "",
      this.dueDate = -1,
      this.priority = Status.PRIORITY_4}) {
    if (this.dueDate == -1) {
      this.dueDate = DateTime.now().millisecondsSinceEpoch;
    }
    this.tasksStatus = TaskStatus.PENDING;
  }

  bool operator ==(o) => o is Task && o.id == id;

  Task.update(
      {@required this.id,
      @required this.title,
      @required this.projectId,
      this.comment = "",
      this.dueDate =-1,
      this.priority = Status.PRIORITY_4,
      this.tasksStatus = TaskStatus.PENDING}) {
    if (this.dueDate == -1) {
      this.dueDate = DateTime.now().millisecondsSinceEpoch;
    }
  }

  Task.fromMap(Map<String, dynamic> map)
      : this.update(
          id: map[dbId],
          title: map[dbTitle],
          projectId: map[dbProjectID],
          comment: map[dbComment],
          dueDate: map[dbDueDate],
          priority: Status.values[map[dbPriority]],
          tasksStatus: TaskStatus.values[map[dbStatus]],
        );
  void setComplete(bool value) {
    _completed = value;
  }

  isCompleted() => _completed;
}

enum TaskStatus {
  PENDING,
  COMPLETE,
}
