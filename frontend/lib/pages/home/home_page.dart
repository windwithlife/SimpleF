import 'package:flutter/material.dart';
import '../common/page.dart';
import './model/HomeModel.dart';

class HomePage extends Page {
  HomeModel pageModel = new HomeModel();
  HomePage(){
    print('create a now object of HomePage Class');
  }
  @override
  void initialize(){
      //this.initExtModel(new HomeModel());
      print('initialize in home page!');
  }
  
  Widget buildPageBody(BuildContext context){
     return new Text('homepage');
  }

  @override
  Widget buildBody(BuildContext context){
    return ChangeNotifierProvider.value(value: this.pageModel,child: this.buildPageBody(context));
    //return new Text('homepage');
   
  }
  
}
