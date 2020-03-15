import 'package:flutter/material.dart';

import '../common/page.dart';
import './model/TasksModel.dart';
import '../../utils/app_util.dart';
import '../../application.dart';
import './model/TaskProjectModel.dart';
import './model/TodoProjectEntity.dart';

class TaskProjectList extends Page {
  //final TasksModel pageModel;

  TaskProjectList(); //: pageModel = TasksModel.instance;

  @override
  void initialize(ModelRegister register) {
    //register.registerModel(ChangeNotifierProvider.value(value: this.pageModel));
    //register.registerModel(ChangeNotifierProvider.value(value: TaskProjectModel()));

    this.hasAppBar(true);
    this.initTitle("分类项目管理");
    //this.pageModel.getallPendingTasksList();
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
        this.goto(context, "/task/addTaskProject");
      },
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return this._buildTaskList(context);
  }

  Widget _buildTaskList(BuildContext context) {
    return Store.connect<TaskProjectModel>(
        builder: (BuildContext context, TaskProjectModel model, Widget child) {
      List<Project> list = model.todoProjects;
      print('render now task  project counter is ${list.length}');
      return Padding(
        padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 35.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
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
                                    var projectID = list[index].id;
                                    String message = "";
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      //model.updateStatus(
                                      //   projectID, TaskStatus.COMPLETE);
                                      //message = "Task completed";
                                    } else {
                                      model.remove(projectID);
                                      message = "project deleted";
                                    }
                                    SnackBar snackbar =
                                        SnackBar(content: Text(message));
                                    Scaffold.of(context).showSnackBar(snackbar);
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
                                  child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                      width: MediaQuery.of(context).size.width -
                                          30,
                                      child: Text(list[index].name)
                                      )); //Text(list[index].title)); //TaskRow(list[index]));
                            }),
                      ),
              )
            ]), //Column
      );
    });
  }
}
