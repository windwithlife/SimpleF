import 'package:flutter/material.dart';

import '../common/page.dart';
import './model/TasksModel.dart';
import '../../utils/app_util.dart';
import './model/TaskEntity.dart';
import './block/task_row.dart';
import '../../application.dart';
import './model/TodoProjectEntity.dart';

class TasksPage extends Page {
  //TasksModel pageModel = TasksModel.instance;
  Project todoProject;
  TasksPage(Map<String, List<String>> params) {
    int pId = int.parse(params["projectId"].first);
    this.todoProject = Project.update(id: pId, name: "tempname");
  }
  @override
  void initialize(ModelRegister register) {
    TasksModel globalModel = Store.valueOf<TasksModel>();
    print('initialize in taskslist page!');
    this.hasAppBar(true);
    this.initTitle("任务管理");
    globalModel.getallPendingTasksList();
  }

  @override
  Widget buildFloatActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
      backgroundColor: Colors.orange,
      onPressed: () {
        this.goto(context, "/task/addTask");
      },
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return _buildTaskList();
  }
  Widget _buildTaskList() {
    //List<Tasks> list = this.pageModel.tasksList;
    return Store.connect<TasksModel>(
        builder: (BuildContext context, TasksModel model, Widget child) {
      List<Task> list = model.tasksList;
      print(' *************no render now task counter is ${list.length}');
      return Stack(children: <Widget>[
        Hero(
          tag: this.todoProject.uuid + "_background",
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0.0),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 35.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Hero(
                      tag: this.todoProject.uuid + "_icon",
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.grey.withAlpha(70),
                              style: BorderStyle.solid,
                              width: 1.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            this.todoProject.icon,
                            color: this.todoProject.color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Hero(
                      tag: this.todoProject.uuid + "_title",
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          this.todoProject.name,
                          style: TextStyle(fontSize: 30.0),
                          softWrap: false,
                        ),
                      ),
                    ),
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Hero(
                      tag: this.todoProject.uuid + "_progress_bar",
                      child: Material(
                        color: Colors.transparent,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: LinearProgressIndicator(
                                value: this.todoProject.percentComplete(),
                                backgroundColor: Colors.grey.withAlpha(50),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    this.todoProject.color),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Text(
                                  (this.todoProject.percentComplete() * 100).round().toString() + "%"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                 
                new Expanded(
                  flex: 2,
                  child: list.length == 0
                      ? MessageInCenterWidget("No Task Added")
                      : Container(
                          child: ListView.builder(
                              itemCount: list.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Dismissible(
                                    key: ObjectKey(list[index]),
                                    onDismissed: (DismissDirection direction) {
                                      var taskID = list[index].id;
                                      String message = "";
                                      if (direction ==
                                          DismissDirection.endToStart) {
                                        model.updateStatus(
                                            taskID, TaskStatus.COMPLETE);
                                        message = "Task completed";
                                      } else {
                                        model.delete(taskID);
                                        message = "Task deleted";
                                      }
                                      SnackBar snackbar =
                                          SnackBar(content: Text(message));
                                      Scaffold.of(context)
                                          .showSnackBar(snackbar);
                                    },
                                    background: Container(
                                      color: Colors.red,
                                      child: ListTile(
                                        leading: Icon(Icons.delete,
                                            color: Colors.white),
                                      ),
                                    ),
                                    secondaryBackground: Container(
                                      color: Colors.green,
                                      child: ListTile(
                                        trailing: Icon(Icons.check,
                                            color: Colors.white),
                                      ),
                                    ),
                                    child: TaskRow(list[
                                        index])); //Text(list[index].title)); //TaskRow(list[index]));
                              }),
                        ),
                )
              ]), //Column
        )
      ]);
    });
  }
}
