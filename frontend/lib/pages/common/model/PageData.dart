import 'package:flutter/foundation.dart' show ChangeNotifier;
import '../../../store/model/BaseModel.dart';

class PageData extends BaseModel {
  String titleName = "page-name from model";
  //int currentPageIndex = 0;
  bool sideDrawerExisted = false;
  bool appBarExistd = false;
  
  void setTitleName (name) {
    this.titleName = name;
    notifyListeners();
  }
  void updateTitile(String name){
    this.titleName = name;
    this.refresh();
  }
}