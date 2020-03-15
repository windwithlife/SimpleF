import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../model/TodoProjectEntity.dart';



class PageSliderCard extends StatelessWidget {
  
  final Function onJumpTo;
  final Project todoObject;
  PageSliderCard(this.todoObject,this.onJumpTo);
    
  
  @override
  Widget build(BuildContext context) {
    
                  double percentComplete = todoObject.percentComplete();

                  return Padding(
                    padding:
                        EdgeInsets.only(left: 10.0, right: 10.0, bottom: 30.0),
                    child: InkWell(
                      onTap: () {
                        this.onJumpTo();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withAlpha(70),
                                  offset: Offset(3.0, 10.0),
                                  blurRadius: 15.0)
                            ]),
                        height: 450.0,
                        child: Stack(
                          children: <Widget>[
                            Hero(
                              tag: todoObject.uuid + "_background",
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 10,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Stack(
                                          children: <Widget>[
                                            Hero(
                                              tag:
                                                  todoObject.uuid + "_backIcon",
                                              child: Material(
                                                type: MaterialType.transparency,
                                                child: Container(
                                                  height: 0,
                                                  width: 0,
                                                  child: IconButton(
                                                    icon:
                                                        Icon(Icons.arrow_back),
                                                    onPressed: null,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Hero(
                                              tag: todoObject.uuid + "_icon",
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Colors.grey
                                                          .withAlpha(70),
                                                      style: BorderStyle.solid,
                                                      width: 1.0),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(todoObject.icon,
                                                      color: todoObject.color),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Hero(
                                          tag: todoObject.uuid + "_more_vert",
                                          child: Material(
                                            color: Colors.transparent,
                                            type: MaterialType.transparency,
                                            child: PopupMenuButton(
                                              icon: Icon(
                                                Icons.more_vert,
                                                color: Colors.grey,
                                              ),
                                              itemBuilder: (context) => <
                                                  PopupMenuEntry<
                                                      TodoCardSettings>>[
                                                PopupMenuItem(
                                                  child: Text("Edit Color"),
                                                  value: TodoCardSettings
                                                      .edit_color,
                                                ),
                                                PopupMenuItem(
                                                  child: Text("Delete"),
                                                  value:
                                                      TodoCardSettings.delete,
                                                ),
                                              ],
                                              onSelected: (setting) {
                                                switch (setting) {
                                                  case TodoCardSettings
                                                      .edit_color:
                                                    print("edit color clicked");
                                                    break;
                                                  case TodoCardSettings.delete:
                                                    print("delete clicked");
                                                    //setState(() {
                                                    //todos.remove(todoObject);
                                                    //});
                                                    break;
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Hero(
                                    tag: todoObject.uuid + "_number_of_tasks",
                                    child: Material(
                                        color: Colors.transparent,
                                        child: Text(
                                          todoObject.taskAmount().toString() +
                                              " Tasks",
                                          style: TextStyle(),
                                          softWrap: false,
                                        )),
                                  ),
                                  Spacer(),
                                  Hero(
                                    tag: todoObject.uuid + "_title",
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Text(
                                        todoObject.name,
                                        style: TextStyle(fontSize: 30.0),
                                        softWrap: false,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Hero(
                                    tag: todoObject.uuid + "_progress_bar",
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: LinearProgressIndicator(
                                              value: percentComplete,
                                              backgroundColor:
                                                  Colors.grey.withAlpha(50),
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      todoObject.color),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5.0),
                                            child: Text((percentComplete * 100)
                                                    .round()
                                                    .toString() +
                                                "%"),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
               
    
  }
}
