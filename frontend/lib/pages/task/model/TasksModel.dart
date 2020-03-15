import 'package:flutter/foundation.dart' show ChangeNotifier;

import '../../../store/model/BaseModel.dart';
import './TaskEntity.dart';
import './task_db.dart';
//import './project_db.dart';
//import './TodoProjectEntity.dart';


class TasksModel extends BaseModel {
  
  Task currentTask = Task.create(
        title: "name",
        // dueDate: dueDateSelected,
        // priority: status,
        // projectId: project.id,
      );
  

  final TaskDB _taskDB = TaskDB.get();
  List<Task> tasksList = new  List<Task>();
  @override
  bool hasData(){
    return true;
    if (tasksList.length <=0){ return false;}else{return true;}
    //return false;
  }
  void getallPendingTasksList(){
      this.refreshTasksList(0, 0, TaskStatus.PENDING).then((value){this.refresh();});
      //this.refresh();
  }
  Future refreshTasksList(int taskStartTime, int taskEndTime, TaskStatus status) {
    return _taskDB
        .getTasks(
            startDate: taskStartTime, endDate: taskEndTime, taskStatus: status)
        .then((tasks) {
          this.tasksList.clear();
          this.tasksList.addAll(tasks);
          print('have got tasks from db by status:' + status.toString());
         
    });
  }


  Future save(){
   
    return _taskDB.updateTask(this.currentTask).then((value){
      this.refreshTasksList(0, 0, TaskStatus.PENDING).then((value){this.refresh();});
      });
  }
  void updateStatus(int taskID, TaskStatus status) {

    _taskDB.updateTaskStatus(taskID, status).then((value) {
       this.refreshTasksList(0, 0, TaskStatus.PENDING).then((vaue){this.refresh();});
       //this.refresh();
    });
   
  }

  void delete(int taskID) {
    _taskDB.deleteTask(taskID).then((value) {
      this.refreshTasksList(0, 0, TaskStatus.PENDING).then((vaue){this.refresh();});
      //this.refresh();
    });
   
  }

}