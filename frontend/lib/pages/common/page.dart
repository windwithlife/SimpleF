import 'package:flutter/material.dart';
import './base_page.dart';
import '../../application.dart';
export '../../application.dart';
import './page_wrapper.dart';
export './page_wrapper.dart';
import './model/PageData.dart';
import '../common/processing.dart';

class Page extends BasePage {
  final PageData pageData;
  Page(): pageData = new PageData();

  @override
  void initialize(ModelRegister register) {
    print('initialze in Page class');

  }
  
  void onPageBack() {}

  PageWrapper create() {
    return new PageWrapper(this,ChangeNotifierProvider.value(value: this.pageData));
  }

  @override
  void goto(BuildContext context, String url) {
    Application.router.navigateTo(context, url);
  }

  void initTitle(String titleName) {
    this.pageData.titleName = titleName;
  }

  void updateTitle(String titleName) {
    this.pageData.setTitleName(titleName);
  }

  void hasSideDrawer(isExisted) {
    this.pageData.sideDrawerExisted = isExisted;
  }

  void hasAppBar(isExisted) {
    this.pageData.appBarExistd = isExisted;
  }

  void onSwithPage() {}

  void addActionItems(List<ActionItemObject> actions) {
    this.pageData.addActionItems(actions);
  }

  void onAppBarActionClick(dynamic selected) {
    print('current action is selected is:$selected');
  }

  List<Widget> _buildActions(BuildContext context) {
    //return <Widget>[_buildPopupMenu(context)];
    PageData model = Store.value<PageData>(context);
    List<Widget> actions = new List<Widget>();
    model.actionList.forEach((element) {
      actions.add(IconButton(
        icon: element.icon,
        onPressed: () {
          this.onAppBarActionClick(element.tag);
        },
      ));
    });
    return actions;
  }

  @override
  Widget buildAppBar(BuildContext context) {
    PageData model = Store.value<PageData>(context);
    return new AppBar(
      title: new Text(model.titleName),
      actions: _buildActions(context),
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

  void showProcessing(BuildContext context){
    ProgressDialog.showProgress(context);
  }
  void hideProcessing(BuildContext context){
    ProgressDialog.dismiss(context);
  }
  @override
  Widget build(BuildContext context) {
    PageData model = Store.value<PageData>(context);
    
    var page = new Scaffold(
      appBar: model.appBarExistd ? buildAppBar(context) : null,
      drawer: model.sideDrawerExisted ? buildSideDrawer(context) : null,
      floatingActionButton: this.buildFloatActionButton(context),
      bottomNavigationBar: buildBottomNavigationBar(context),
      body: buildBody(context), //new Text('${this.goodId}'),
    );

    
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
    //return ChangeNotifierProvider.value(value: this.pageData, child: page);
    return page;
    
  } 
}
