import 'package:flutter/foundation.dart' show ChangeNotifier;


class HomeModel extends ChangeNotifier {
  String titleName = "homepage";
  int currentPageIndex = 0;
  
  

  void setTitleName (name) {
    this.titleName = name;
    notifyListeners();
  }
  void setCurrentPageIndex(int index){
    this.currentPageIndex = index;
    notifyListeners();
  }
  void initModel(String name,currentPageIndex){
    this.titleName = name;
    this.currentPageIndex = currentPageIndex;
  }
}