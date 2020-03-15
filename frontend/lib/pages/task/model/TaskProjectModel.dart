import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter/material.dart';
import '../../../store/model/BaseModel.dart';
import './TaskEntity.dart';
import './task_db.dart';
import './project_db.dart';
import './TodoProjectEntity.dart';



List<Project> todos = [
  
  Project.create("Personal"),
  Project.create("Work"),
  Project.create("Home"),
  Project.create("Shopping"),
  Project.create("School"),
];

class TaskProjectModel extends BaseModel {
  
  TaskProjectModel(){
    this.refreshAllProjects();
  }
 
  Project currentProject = Project.create("test");
  final ProjectDB _projectDB = ProjectDB.get();
  List<Project> todoProjects = todos;
  LinearGradient backgroundGradient;


 void changePageBackground(bg){
    this.backgroundGradient = bg;
    this.refresh();
  }


  void refreshAllProjects(){
     this._projectDB.getProjects().then((projects){
      this.todoProjects.clear();
      this.todoProjects.addAll(projects);
      print('have refresh projects!');
      this.refresh();
    });
  }
  Future save(){
    return _projectDB.insertOrReplace(this.currentProject).then((value){this.refreshAllProjects();});
  }

  Future remove(int projectID){
    return _projectDB.deleteProject(projectID).then((value){print('have remove project ID: $projectID');this.refreshAllProjects();});
  }

}