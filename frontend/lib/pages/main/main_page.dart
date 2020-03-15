import 'package:flutter/material.dart';
import 'package:hello/store/model/UserModel.dart';
import '../common/page.dart';

import '../task/todo_home.dart';
import './model/MainPageModel.dart';
//import '../task/task_widgets.dart';
import '../home/CategoriesScreen.dart';
import '../reading/reading_home.dart';

class MainPage extends Page {
  final MainPageModel pageModel = new MainPageModel();

  
  @override
  void initialize(ModelRegister register) {
     register.registerModel(ChangeNotifierProvider.value(value:this.pageModel));

    this.pageModel.pagesList.add(new CategoriesScreen().create());
    this.pageModel.pagesList.add(TodoHomePage().create());
    this.pageModel.pagesList.add(ReadingHomePage().create());
    

    //this.pageModel.pagesList.add(new TasksPage().create()); 
  }

  @override
  BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
    var bar = new BottomNavigationBar(
        //通过fixedColor设置选中item的颜色
        fixedColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        //当前页面索引
        //currentIndex: _currentIndex,
        //按下后设置当前页面索引
        onTap: ((index) {
          this.pageModel.setCurrentPageIndex(index);
        }),
        //底部导航按钮项
        items: [
          new BottomNavigationBarItem(
              title: new Text('首页'), icon: Icon(Icons.home)),
          new BottomNavigationBarItem(
              title: new Text('备忘'), icon: Icon(Icons.note)),
          new BottomNavigationBarItem(
              title: new Text('阅读'), icon: Icon(Icons.info)),
          new BottomNavigationBarItem(
              title: new Text('金融'), icon: Icon(Icons.note)),
          new BottomNavigationBarItem(
              title: new Text('我的'), icon: Icon(Icons.person)),
        ]);
    return bar;
  }

  Widget buildPageBody(BuildContext context) {
    return Store.connect<MainPageModel>(
        builder: (BuildContext context, MainPageModel model, Widget child) {
      var currentPage = model.currentPageIndex;
      //print(this.pageModel.pagesList);
      print('current page index:${currentPage}');
      var page = model.pagesList[currentPage];
      if (page is Page){
         page.onSwithPage();
      }
      return IndexedStack(
        index: currentPage,
        children: model.pagesList,
      );
      //return this.pageModel.pagesList[currentPage];
    });
  }

  @override
  Widget buildBody(BuildContext context) {
    return this.buildPageBody(context);
    //return new Text('homepage');
  }
}
