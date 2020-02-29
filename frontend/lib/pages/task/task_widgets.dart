import 'package:flutter/material.dart';

import '../common/page.dart';
import './model/TasksModel.dart';
import '../../utils/app_util.dart';
import './model/tasks.dart';
import './row_task.dart';
import '../../application.dart';

class TasksPage extends Page {
  TasksModel pageModel = TasksModel.instance;

  @override
  void initialize(){
    print('initialize in taskslist page!');
    
  }

  @override
  void onConfigPageBeforeShow(BuildContext cxt) {
    // TODO: implement onConfigPageBeforeShow
    super.onConfigPageBeforeShow(cxt);
    this.hasAppBar(true);
    this.initTitle("任务管理");
  }
  @override
  void willUpdatePage(){
    this.pageModel.getallPendingTasksList();
  }
  // @override
  // void showPageTrace(String info){
  //    print("TaskListPage of " + info);
  // }
  @override 
  Widget buildFloatActionButton(BuildContext context){
    return FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
        onPressed: (){
          this.goto(context,"/addTask");
        },
      );
  }
  @override
  Widget buildBody(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: this.pageModel, child: this._buildPageBody(context));
  }

  Widget _buildPageBody(BuildContext context) {
    
    if (pageModel.hasData()) {
      return buildTaskList();
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget buildTaskList() {
    //List<Tasks> list = this.pageModel.tasksList;
    return Store.connect<TasksModel>(builder: (BuildContext context,
                TasksModel model, Widget child) {
           List<Tasks> list = model.tasksList;     
           print(' *************no render now task counter is ${list.length}');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: list.length == 0
          ? MessageInCenterWidget("No Task Added")
          : Container(
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                        key: ObjectKey(list[index]),
                        onDismissed: (DismissDirection direction) {
                          var taskID = list[index].id;
                          String message = "";
                          if (direction == DismissDirection.endToStart) {
                            model.updateStatus(taskID, TaskStatus.COMPLETE);
                            message = "Task completed";
                          } else {
                            model.delete(taskID);
                            message = "Task deleted";
                          }
                          SnackBar snackbar = SnackBar(content: Text(message));
                          Scaffold.of(context).showSnackBar(snackbar);
                        },
                        background: Container(
                          color: Colors.red,
                          child: ListTile(
                            leading: Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                        secondaryBackground: Container(
                          color: Colors.green,
                          child: ListTile(
                            trailing: Icon(Icons.check, color: Colors.white),
                          ),
                        ),
                        child: TaskRow(list[index]));//Text(list[index].title)); //TaskRow(list[index]));
                  }),
            ),
    );
                });
  }
}
