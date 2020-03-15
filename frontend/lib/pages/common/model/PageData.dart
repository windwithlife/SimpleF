//import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter/material.dart';
import '../../../store/model/BaseModel.dart';
class ActionItemObject{
  ActionItemObject(this.icon,this.tag,{this.name});
  Icon icon;
  String name;
  dynamic tag;
}

class PageData extends BaseModel {
  String titleName = "page-name from model";
  //int currentPageIndex = 0;
  bool sideDrawerExisted = false;
  bool appBarExistd = false;
  List<ActionItemObject> actionList = new List<ActionItemObject>();

  void setTitleName (name) {
    this.titleName = name;
    notifyListeners();
  }
  void updateTitile(String name){
    this.titleName = name;
    this.refresh();
  }
  void addActionItems(List<ActionItemObject> actions){
     this.actionList.clear();
     this.actionList.addAll(actions);
  }
}