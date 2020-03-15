import '../../../store/model/priority.dart';
import 'package:meta/meta.dart';

class Readings {
  static final tblTask = "ReadingStore";
  static final dbId = "id";
  static final dbTitle = "title";
  static final dbComment = "comment";
  static final dbCreatedDate = "createdDate";
  static final dbPriority = "priority";
  static final dbStatus = "status";
  static final dbProjectID = "projectId";
  static final dbContentText ="contentText";
  static final dbSourceUrl   = "sourceUrl";
  static final dbContentType = "isLinked";
  static final dbTag ="tag";

  String title, comment, projectName;
  int id, createdDate, projectId;
  Status priority;
  

  Readings.create(
      {@required this.title,
      // @required this.projectId,
      this.comment = "",
      this.createdDate = -1,
      this.priority = Status.PRIORITY_4}) {
    if (this.createdDate == -1) {
      this.createdDate = DateTime.now().millisecondsSinceEpoch;
    }
  
  }


  Readings.update(
      {@required this.id,
      @required this.title,
      @required this.projectId,
      this.comment = "",
      this.createdDate =-1,
      this.priority = Status.PRIORITY_4,}) {
    if (this.createdDate == -1) {
      this.createdDate = DateTime.now().millisecondsSinceEpoch;
    }
  }

  Readings.fromMap(Map<String, dynamic> map)
      : this.update(
          id: map[dbId],
          title: map[dbTitle],
          projectId: map[dbProjectID],
          comment: map[dbComment],
          createdDate: map[dbCreatedDate],
          priority: Status.values[map[dbPriority]],
        
        );
 
}