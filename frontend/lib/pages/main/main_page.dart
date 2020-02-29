import 'package:flutter/material.dart';
import '../common/page.dart';

import '../task/Home.dart';
import './model/MainPageModel.dart';
import '../task/task_widgets.dart';
import '../home/CategoriesScreen.dart';

class MainPage extends Page {
  MainPageModel pageModel = MainPageModel.instance;
  @override
  void initialize() {
    //print('*****************init main page!!!');
    this.pageModel.pagesList.add(new CategoriesScreen().create());
    this.pageModel.pagesList.add(new TasksPage().create());
    this.pageModel.pagesList.add(HomePage());
    //this.pageData.showAppBar(true);
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
              title: new Text('资讯'), icon: Icon(Icons.info)),
          new BottomNavigationBarItem(
              title: new Text('金融'), icon: Icon(Icons.note)),
          new BottomNavigationBarItem(
              title: new Text('记事'), icon: Icon(Icons.note)),
          new BottomNavigationBarItem(
              title: new Text('我的'), icon: Icon(Icons.person)),
        ]);
    return bar;
  }

  Widget buildPageBody(BuildContext context) {
    return Store.connect<MainPageModel>(
        builder: (BuildContext context, MainPageModel data, Widget child) {
      var currentPage = data.currentPageIndex;
      print(this.pageModel.pagesList);
      print('current page index:${currentPage}');
      return IndexedStack(
        index: currentPage,
        children: this.pageModel.pagesList,
      );
      //return this.pageModel.pagesList[currentPage];
    });
  }

  @override
  Widget buildBody(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: this.pageModel, child: this.buildPageBody(context));
    //return new Text('homepage');
  }
}
