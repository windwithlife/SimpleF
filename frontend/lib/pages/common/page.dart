import 'package:flutter/material.dart';
import './base_page.dart';
import '../../application.dart';
export '../../application.dart';
import './page_wrapper.dart';
import './side_drawer.dart';
import './model/PageData.dart';

class Page extends BasePage {
  PageData pageData = new PageData();

  @override
  void initialize() {
    print('initialze in Page class');
  }

  void willUpdatePage() {}
  void showPageTrace(String info) {
    print(info);
  }

  PageWrapper create() {
    return new PageWrapper(this);
  }

  @override
  void goto(BuildContext context, String url) {
    Application.router.navigateTo(context, url);
  }
  void onConfigPageBeforeShow(BuildContext cxt){}

  void initTitle(String titleName) {
    this.pageData.titleName =titleName;
  }
  
  void hasSideDrawer(isExisted) {
    this.pageData.sideDrawerExisted = isExisted;
  }
  void hasAppBar(isExisted) {
    this.pageData.appBarExistd =isExisted;
  }

  void updateTitle(String titleName) {
    this.pageData.setTitleName(titleName);
  }

  @override
  Widget buildAppBar(BuildContext context) {
  
      return new AppBar(
        title: Store.connect<PageData>(builder: 
             (BuildContext context, PageData snapshot, Widget child) {
               return new Text(snapshot.titleName);}),
        actions: <Widget>[buildPopupMenu(context)],
      );
   
  }

  @override
  Widget buildSideDrawer(BuildContext context) {
    return null;
  }

  @override
  Widget buildBody(BuildContext context) {
    return new Text('page-body');
  }

  Widget buildPopupMenu(BuildContext context) {
    return PopupMenuButton<MenuItem>(
      onSelected: (MenuItem result) async {
        switch (result) {
          case MenuItem.taskCompleted:
            Application.router.navigateTo(context, '/secondPage');
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
        const PopupMenuItem<MenuItem>(
          value: MenuItem.taskCompleted,
          child: const Text('Completed Tasks'),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //Store.setCurrentPageContext(context);
    this.onConfigPageBeforeShow(context);
    var page = new Scaffold(
      appBar: this.pageData.appBarExistd ? buildAppBar(context) : null,
      drawer: this.pageData.sideDrawerExisted ? buildSideDrawer(context) : null,
      floatingActionButton: this.buildFloatActionButton(context),
      bottomNavigationBar: buildBottomNavigationBar(context),
      body: buildBody(context), //new Text('${this.goodId}'),
    );

    //ChangeNotifierProvider provider = null;
    //Widget tempObject = page;
    //for(int i=0; i< this._modelLsit.length;i++){
    //var provider = ChangeNotifierProvider.value(
    //         value: data,
    //          child: tempObject);
    //         tempObject =provider;
    //}

    //return provider;
    /*
    print('*************rebuild in page class processing***************');
    if (null != this.pageBizModel) {
      print('*************rebuild in page class process biz**************');
      return ChangeNotifierProvider.value(
              value: this.pageBizModel,
              child: ChangeNotifierProvider.value(
                  value: this.pageData, child: page));
    } else {
      */
    //print('*************rebuild in page class process base pagedata**************');
    return ChangeNotifierProvider.value(value: this.pageData, child: page);
    //ChangeNotifierProvider(
    //       builder: (context) => this.pageData, child: page);
    //}
  } // build
}

enum MenuItem { taskCompleted }
