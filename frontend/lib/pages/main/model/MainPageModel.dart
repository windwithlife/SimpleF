import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter/material.dart';

class MainPageModel extends ChangeNotifier {
  MainPageModel._privateConstructor();
  static final MainPageModel instance = MainPageModel._privateConstructor();

  String titleName = "mainPage";
  int currentPageIndex = 0;
  
  List<Widget> pagesList = new List<Widget>();
  void setTitleName (name) {
    this.titleName = name;
    notifyListeners();
  }
  void setCurrentPageIndex(int index){
    this.currentPageIndex =index;
    notifyListeners();
  }
  void initModel(String name,currentPageIndex){
    this.titleName = name;
    this.currentPageIndex = currentPageIndex;
  }
}